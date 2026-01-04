return {
	{
		"rcarriga/nvim-notify",
		opts = {
			top_down = false,
			stages = "slide",
			timeout = 3000,
			max_width = 50,
			max_height = 10,
		},
		config = function(_, opts)
			local notify = require("notify")
			notify.setup(opts)
			vim.notify = notify
		end,
	},
}
