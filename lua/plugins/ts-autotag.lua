return {
	"windwp/nvim-ts-autotag",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("nvim-ts-autotag").setup({
			opts = {
				enable_close = true,
				enable_rename = true,
				enable_close_on_slash = false,
			},
			filetypes = {
				"html",
				"javascript",
				"typescript",
				"javascriptreact",
				"typescriptreact",
				"svelte",
				"vue",
				"xml",
			},
			per_filetype = {
				["html"] = { enable_close = true },
			},
		})

		vim.diagnostic.config({
			virtual_text = {
				spacing = 5,
				severity = vim.diagnostic.severity.WARN,
			},
			underline = true,
			update_in_insert = true,
		})

		-- Optional: remap '>' to auto close tag instantly in insert mode
		vim.api.nvim_set_keymap("i", ">", "><C-x><C-o>", { noremap = true, silent = true })
	end,
}
