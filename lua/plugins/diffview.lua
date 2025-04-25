return {
	"sindrets/diffview.nvim",
	cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local diffview = require("diffview")

		diffview.setup({
			view = {
				merge_tool = {
					layout = "diff3_mixed",
					disable_diagnostics = true,
				},
			},
		})

		-- Keybindings for Diffview
		local keymap = vim.keymap.set
		local opts = { noremap = true, silent = true, desc = "DiffView" }

		keymap("n", "<leader>gd", ":DiffviewOpen<CR>", vim.tbl_extend("force", opts, { desc = "Open DiffView" }))
		keymap("n", "<leader>gD", ":DiffviewClose<CR>", vim.tbl_extend("force", opts, { desc = "Close DiffView" }))
		keymap(
			"n",
			"<leader>gf",
			":DiffviewToggleFiles<CR>",
			vim.tbl_extend("force", opts, { desc = "Toggle Files Panel" })
		)
		keymap(
			"n",
			"<leader>gF",
			":DiffviewFocusFiles<CR>",
			vim.tbl_extend("force", opts, { desc = "Focus Files Panel" })
		)
	end,
}
