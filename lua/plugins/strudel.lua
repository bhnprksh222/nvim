return {
	"gruvw/strudel.nvim",
	build = "npm ci",
	config = function()
		local strudel = require("strudel")
		strudel.setup({
			ui = {
				maximise_menu_panel = true, -- show huge Strudel menu
				hide_menu_panel = false,
				hide_top_bar = false,
				hide_error_display = false,
				hide_code_editor = false,
			},
			start_on_launch = true, -- start playback automatically
			update_on_save = false, -- auto-eval on save
			sync_cursor = true, -- two-way cursor sync
		})

		vim.keymap.set("n", "<leader>ml", strudel.launch, { desc = "Launch Strudel" })
		vim.keymap.set("n", "<leader>mq", strudel.quit, { desc = "Quit Strudel" })
		vim.keymap.set("n", "<leader>mt", strudel.toggle, { desc = "Play/Stop Strudel" })
		vim.keymap.set("n", "<leader>mu", strudel.update, { desc = "Update / Eval" })
		vim.keymap.set("n", "<leader>mb", strudel.set_buffer, { desc = "Set Strudel Buffer" })
	end,
}
