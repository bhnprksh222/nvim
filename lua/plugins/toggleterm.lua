-- plugins/toggleterm.lua
return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			size = 15,
			open_mapping = [[<leader>to]], -- replaces <leader>to from floaterm
			direction = "horizontal",
			float_opts = {
				border = "curved",
			},
			shade_terminals = true,
			persist_size = true,
			start_in_insert = true,
		})

		local Terminal = require("toggleterm.terminal").Terminal

		-- New floating terminal (like FloatermNew)
		vim.keymap.set("n", "<leader>tn", function()
			Terminal:new({ direction = "float" }):toggle()
		end, { noremap = true, silent = true, desc = "New Floating Terminal" })

		-- Next terminal (toggleterm tracks numbered terminals)
		vim.keymap.set(
			"n",
			"<leader>tj",
			":ToggleTerm direction=float count=1<CR>",
			{ noremap = true, silent = true, desc = "Next Terminal" }
		)

		-- Previous terminal (not native to toggleterm, but you can remap to fixed count)
		vim.keymap.set(
			"n",
			"<leader>tk",
			":ToggleTerm direction=float count=2<CR>",
			{ noremap = true, silent = true, desc = "Previous Terminal" }
		)

		-- Toggle current terminal with <leader>to
		vim.keymap.set("t", "<leader>to", "<C-\\><C-n>:ToggleTerm<CR>", { noremap = true, silent = true })
	end,
}
