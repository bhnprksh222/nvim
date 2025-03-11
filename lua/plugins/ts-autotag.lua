return {
	"windwp/nvim-ts-autotag",
	event = { "BufReadPre", "BufNewFile" }, -- Load early for better responsiveness
	config = function()
		-- Configure nvim-ts-autotag
		require("nvim-ts-autotag").setup({
			opts = {
				enable_close = true, -- Auto close tags when typing '>'
				enable_rename = true, -- Auto rename when modifying opening/closing tag
				enable_close_on_slash = false, -- Do not auto-close on typing '</'
			},
			filetypes = { "html", "javascript", "typescript", "javascriptreact", "typescriptreact" },
			per_filetype = {
				["html"] = { enable_close = true }, -- Ensure auto-close works for HTML
			},
		})

		-- Enable live updates when renaming tags
		vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
			underline = true,
			virtual_text = {
				spacing = 5,
				severity_limit = "Warning",
			},
			update_in_insert = true, -- Update closing tag while typing
		})
		vim.api.nvim_set_keymap("i", ">", "><C-x><C-o>", { noremap = true, silent = true })
	end,
}
