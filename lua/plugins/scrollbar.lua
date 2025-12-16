-- plugins/nvim-scrollview.lua
return {
	"dstein64/nvim-scrollview",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		require("scrollview").setup({
			signs_on_startup = { "all" },
			current_only = true,
			winblend = 30,
			base = "right", -- put scrollbar on right side
			column = 1,
			diagnostics_severities = { vim.diagnostic.severity.ERROR },
		})
	end,
}
