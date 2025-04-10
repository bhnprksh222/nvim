-- Standalone plugins with less than 10 lines of config go here
return {
	{
		-- Tmux & split window navigation
		"christoomey/vim-tmux-navigator",
	},
	{
		-- Detect tabstop and shiftwidth automatically
		"tpope/vim-sleuth",
	},
	{
		-- Powerful Git integration for Vim
		"tpope/vim-fugitive",
	},
	{
		-- GitHub integration for vim-fugitive
		"tpope/vim-rhubarb",
	},
	{
		-- Hints keybinds
		"folke/which-key.nvim",
	},
	{
		-- Autoclose parentheses, brackets, quotes, etc.
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
		opts = {},
	},
	{
		-- Highlight todo, notes, etc in comments
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},
	{
		-- High-performance color highlighter
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},
	{
		-- Edit text with multi-line cursors
		"mg979/vim-visual-multi",
	},
	{
		"APZelos/blamer.nvim",
		event = "BufReadPost",
		init = function()
			-- Set options before plugin loads
			vim.g.blamer_enabled = true
			vim.g.blamer_delay = 500
			vim.g.blamer_show_in_visual_modes = false
			vim.g.blamer_show_in_insert_modes = false
			vim.g.blamer_prefix = " > "
			vim.g.blamer_template = "<committer>, <committer-time> • <summary>"
			vim.g.blamer_date_format = "%d/%m/%y"
			vim.g.blamer_relative_time = true
		end,
		keys = {
			{
				"<space>gb",
				"<cmd>BlamerToggle<CR>",
				desc = "Toggle Git Blame (Blamer)",
			},
		},
	},
}
