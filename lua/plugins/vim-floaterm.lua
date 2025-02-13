return {
	"voldikss/vim-floaterm",
	opts = {},
	config = function()
		local opts = { noremap = true, silent = true }
		vim.api.nvim_set_keymap("n", "<C-`>", ":FloatermToggle<CR>", { noremap = true, silent = true })
		vim.api.nvim_set_keymap("t", "<C-`>", "<C-\\><C-n>:FloatermToggle<CR>", { noremap = true, silent = true })
	end,
}
