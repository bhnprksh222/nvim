-- Function to check and create input/output files if they don't exist
function EnsureCppIOFiles()
	local filetype = vim.bo.filetype
	if filetype ~= "cpp" then
		print("❌ Not a C++ file.")
		return false
	end

	-- Get the directory of the current C++ file
	local file_path = vim.fn.expand("%:p:h") -- Get directory path
	local input_file = file_path .. "/input.txt"
	local output_file = file_path .. "/output.txt"

	-- Flags to check if files were created
	local created = false

	-- Ensure input.txt exists
	if vim.fn.filereadable(input_file) == 0 then
		vim.fn.writefile({}, input_file) -- Create empty input.txt
		print("✅ Created input.txt")
		created = true
	end

	-- Ensure output.txt exists
	if vim.fn.filereadable(output_file) == 0 then
		vim.fn.writefile({}, output_file) -- Create empty output.txt
		print("✅ Created output.txt")
		created = true
	end

	return true
end

-- Function to set up split windows
function SetupSplitWindows()
	-- Close existing splits before setting up new ones
	vim.cmd("only")

	-- Split window: Left (code), Right (input + output)
	vim.cmd("vsplit") -- Split screen vertically
	vim.cmd("wincmd l") -- Move to right window
	vim.cmd("split") -- Split right side horizontally (input on top, output on bottom)

	-- Get current file path
	local file_path = vim.fn.expand("%:p:h")
	local input_file = file_path .. "/input.txt"
	local output_file = file_path .. "/output.txt"

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

-- Function to check files and open in split mode
function SetupCppEnvironment()
	if EnsureCppIOFiles() then
		SetupSplitWindows()
	end
end

-- Auto setup for C++ files when opened
vim.api.nvim_create_autocmd("BufReadPost", {
	pattern = { "*.cpp" },
	callback = SetupCppEnvironment,
})

-- Manual command to trigger the setup
vim.api.nvim_set_keymap("n", "<leader>r1", ":lua SetupCppEnvironment()<CR>", { noremap = true, silent = true })
