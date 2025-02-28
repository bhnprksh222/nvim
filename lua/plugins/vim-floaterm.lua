return {
	"voldikss/vim-floaterm",
	opts = {},
	config = function()
		local opts = { noremap = true, silent = true }
		vim.api.nvim_set_keymap("n", "<leader>to", ":FloatermToggle<CR>", { noremap = true, silent = true })
		vim.api.nvim_set_keymap("t", "<leader>to", "<C-\\><C-n>:FloatermToggle<CR>", opts)

		-- Open a new floating terminal
		vim.api.nvim_set_keymap("n", "<leader>tn", ":FloatermNew<CR>", opts)

		-- Switch to the next terminal
		vim.api.nvim_set_keymap("n", "<leader>tj", ":FloatermNext<CR>", opts)

		-- Switch to the previous terminal
		vim.api.nvim_set_keymap("n", "<leader>tk", ":FloatermPrev<CR>", opts)
	end,
}
