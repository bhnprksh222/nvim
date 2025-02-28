-- Function to set up split windows for C++ files and create input/output files
function SetupSplitForCpp()
	-- Get the directory of the current C++ file
	local file_path = vim.fn.expand("%:p:h") -- Get directory path
	local input_file = file_path .. "/input.txt"
	local output_file = file_path .. "/output.txt"

	-- Ensure input.txt and output.txt exist in the same directory as the .cpp file
	if vim.fn.filereadable(input_file) == 0 then
		vim.fn.writefile({}, input_file) -- Create empty input.txt
	end
	if vim.fn.filereadable(output_file) == 0 then
		vim.fn.writefile({}, output_file) -- Create empty output.txt
	end

	-- Close existing splits before setting up new ones
	vim.cmd("only")

	-- Split window: Left (code), Right (input + output)
	vim.cmd("vsplit") -- Split screen vertically
	vim.cmd("wincmd l") -- Move to right window
	vim.cmd("split") -- Split right side horizontally (input on top, output on bottom)

	-- Move to right top window (input.txt)
	vim.cmd("wincmd k")
	vim.cmd("e " .. input_file)

	-- Move to right bottom window (output.txt)
	vim.cmd("wincmd j")
	vim.cmd("e " .. output_file)
	vim.cmd("setlocal buftype=nofile") -- Mark output.txt as non-editable

	-- Move back to the left code window (main focus remains on code)
	vim.cmd("wincmd h")
end

-- Function to compile and run C++ files, storing output in output.txt
function BuildAndRunCpp()
	-- Get current file name and directory
	local filename = vim.fn.expand("%:p")
	local file_path = vim.fn.expand("%:p:h") -- Directory path
	local exec_name = file_path .. "/a.out"
	local input_file = file_path .. "/input.txt"
	local output_file = file_path .. "/output.txt"

	-- Compile and run C++ file, store output in output.txt
	local command = "g++ "
		.. vim.fn.shellescape(filename)
		.. " -o "
		.. vim.fn.shellescape(exec_name)
		.. " && "
		.. vim.fn.shellescape(exec_name)
		.. " < "
		.. vim.fn.shellescape(input_file)
		.. " > "
		.. vim.fn.shellescape(output_file)
		.. " 2>&1"

	-- Run command asynchronously
	vim.fn.jobstart(command, {
		on_exit = function()
			-- Refresh output.txt immediately after execution
			for _, win in ipairs(vim.api.nvim_list_wins()) do
				local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(win))
				if bufname == output_file then
					vim.api.nvim_set_current_win(win) -- Switch to the output.txt window
					vim.cmd("e!") -- Force reload output.txt
					break
				end
			end

			-- Manually trigger file check & UI refresh
			vim.cmd("checktime") -- Detect file changes
			vim.cmd("redraw!") -- Force UI update

			-- Return focus to left (code) window
			vim.cmd("wincmd h")
		end,
	})
end

-- Function to check if the current file is a C/C++ file
function RunCppOrShowMessage()
	local filetype = vim.bo.filetype
	if filetype == "cpp" or filetype == "c" then
		BuildAndRunCpp()
	else
		print("❌ This command is only available for C/C++ files.")
	end
end

-- Auto setup for C++ files
vim.api.nvim_create_autocmd("BufReadPost", {
	pattern = { "*.cpp", "*.c" },
	callback = SetupSplitForCpp,
})

-- Auto compile & run when saving a C++ file
vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = { "*.cpp", "*.c" },
	callback = BuildAndRunCpp,
})

-- Map <leader>r to run only for C++ files
vim.api.nvim_set_keymap("n", "<leader>r", ":lua RunCppOrShowMessage()<CR>", { noremap = true, silent = true })
