-- plugins/code_runner_cpp.lua
return {
	"CRAG666/code_runner.nvim",
	config = function()
		require("code_runner").setup({
			filetype = {
				java = {
					"cd $dir &&",
					"javac $fileName &&",
					"java $fileNameWithoutExt",
				},
				python = "python3 -u",
				typescript = "deno run",
				rust = {
					"cd $dir &&",
					"rustc $fileName &&",
					"$dir/$fileNameWithoutExt",
				},
				c = {
					"cd $dir &&",
					"gcc $fileName -o /tmp/$fileNameWithoutExt &&",
					"/tmp/$fileNameWithoutExt < $dir/input.txt > $dir/output.txt &&",
					"rm /tmp/$fileNameWithoutExt",
				},
				cpp = {
					"cd $dir &&",
					"g++ $fileName -o /tmp/$fileNameWithoutExt &&",
					"/tmp/$fileNameWithoutExt < $dir/input.txt > $dir/output.txt &&",
					"rm /tmp/$fileNameWithoutExt",
				},
			},
		})

		-- Keymap: Compile, Run and Refresh Output
		vim.keymap.set("n", "<leader>r", function()
			vim.cmd("RunCode")
			vim.defer_fn(function()
				-- Reload output.txt if open
				for _, buf in ipairs(vim.api.nvim_list_bufs()) do
					if vim.api.nvim_buf_get_name(buf):match("output.txt") then
						vim.api.nvim_buf_call(buf, function()
							vim.cmd("checktime")
						end)
					end
				end
			end, 500)
		end, { desc = "Compile, Run and Refresh Output.txt" })

		-- Autocmd for C++ files: Create input.txt and output.txt in same dir
		vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
			pattern = { "*.cpp", "*.cc", "*.cxx" },
			callback = function()
				local cpp_dir = vim.fn.expand("%:p:h") -- directory of the cpp file
				local input_path = cpp_dir .. "/input.txt"
				local output_path = cpp_dir .. "/output.txt"

				-- Create input.txt and output.txt if not exist
				if vim.fn.filereadable(input_path) == 0 then
					vim.fn.writefile({}, input_path)
				end
				if vim.fn.filereadable(output_path) == 0 then
					vim.fn.writefile({}, output_path)
				end

				-- Only split if not already open
				if vim.fn.bufname() ~= "input.txt" and vim.fn.bufname() ~= "output.txt" then
					vim.cmd("vsplit " .. input_path)
					vim.cmd("split " .. output_path)
					vim.cmd("wincmd h") -- Go back to cpp file
				end
			end,
		})
	end,
}
