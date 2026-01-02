return {
	{
		"ntpeters/vim-better-whitespace",
		config = function()
			-- Enable highlighting
			vim.g.better_whitespace_enabled = 1

			-- Ignored filetypes (optional)
			vim.g.better_whitespace_filetypes_blacklist = {
				"help",
				"terminal",
				"dashboard",
				"markdown",
			}

			-- Highlight trailing whitespace
			vim.g.strip_whitespace_on_save = 1 -- Removes trailing spaces on save
			vim.cmd([[highlight ExtraWhitespace ctermbg=red guibg=red]])
		end,
	},
}
