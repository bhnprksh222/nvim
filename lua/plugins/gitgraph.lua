return {
	"isakbm/gitgraph.nvim",
	opts = {
		symbols = {
			merge_commit = "╳",
			commit = "●",
			merge_commit_end = "╲",
			commit_end = "╱",
		},
		format = {
			timestamp = "%Y-%m-%d %H:%M",
			fields = { "hash", "author", "message", "branch_name", "tag" },
		},
		hooks = {
			on_select_commit = function(commit)
				vim.cmd("tabnew | read !git show " .. commit.hash)
			end,
		},
	},
	keys = {
		{
			"<space>gg",
			function()
				-- Toggle: open if not visible, close if already open
				local bufnr = vim.g.gitgraph_bufnr
				if bufnr and vim.api.nvim_buf_is_valid(bufnr) then
					vim.api.nvim_buf_delete(bufnr, { force = true })
					vim.g.gitgraph_bufnr = nil
				else
					require("gitgraph").draw({}, { all = true, max_count = 1000 })
					vim.defer_fn(function()
						vim.g.gitgraph_bufnr = vim.api.nvim_get_current_buf()
					end, 10)
				end
			end,
			desc = "Toggle GitGraph View",
		},
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
}
