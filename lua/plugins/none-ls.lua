return {
	"nvimtools/none-ls.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
		"jayp0521/mason-null-ls.nvim", -- ensure dependencies are installed
	},
	config = function()
		local null_ls = require("null-ls")
		local formatting = null_ls.builtins.formatting -- to setup formatters
		local diagnostics = null_ls.builtins.diagnostics -- to setup linters

		-- Formatters & linters for mason to install
		require("mason-null-ls").setup({
			ensure_installed = {
				"prettier", -- ts/js formatter
				"stylua", -- lua formatter
				"shfmt", -- Shell formatter
				"checkmake", -- linter for Makefiles
				"ruff", -- Python linter and formatter
				"black", -- Python linter and formatter
			},
			automatic_installation = true,
		})

		local sources = {
			-- diagnostics
			diagnostics.checkmake,

			-- formatting
			formatting.prettier.with({ filetypes = { "html", "json", "yaml", "markdown" } }),
			formatting.stylua,
			formatting.shfmt.with({ args = { "-i", "4" } }),
			formatting.black,
			-- only enable terraform formatter if terraform exists
		}
		if vim.fn.executable("terraform") == 1 then
			table.insert(sources, formatting.terraform_fmt)
		end

		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

		null_ls.setup({
			sources = sources,
			on_attach = function(_, bufnr)
				vim.api.nvim_clear_autocmds({
					group = augroup,
					buffer = bufnr,
				})

				vim.api.nvim_create_autocmd("BufWritePre", {
					group = augroup,
					buffer = bufnr,
					callback = function()
						vim.lsp.buf.format({
							async = false,
							filter = function(c)
								return c.name == "null-ls"
							end,
						})
					end,
				})
			end,
		})
	end,
}
