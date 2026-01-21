-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable the spacebar key's default behavior in Normal and Visual modes
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- For conciseness
local opts = { noremap = true, silent = true }

-- save file
vim.keymap.set("n", "<C-s>", "<cmd> w <CR>", opts)

-- save file without auto-formatting
vim.keymap.set("n", "<leader>sn", "<cmd>noautocmd w <CR>", opts)

-- quit file
vim.keymap.set("n", "<C-q>", "<cmd> q <CR>", opts)

-- delete single character without copying into register
vim.keymap.set("n", "x", '"_x', opts)

-- Vertical scroll and center
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)

-- Find and center
vim.keymap.set("n", "n", "nzzzv", opts)
vim.keymap.set("n", "N", "Nzzzv", opts)

-- Resize with arrows
vim.keymap.set("n", "<Up>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<Down>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<Left>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<Right>", ":vertical resize +2<CR>", opts)

-- Buffers
vim.keymap.set("n", "<Tab>", ":bnext<CR>", opts)
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", opts)
vim.keymap.set("n", "<leader>x", ":bdelete!<CR>", opts) -- close buffer
vim.keymap.set("n", "<leader>b", "<cmd> enew <CR>", opts) -- new buffer

-- Window management
vim.keymap.set("n", "<leader>v", "<C-w>v", opts) -- split window vertically
vim.keymap.set("n", "<leader>h", "<C-w>s", opts) -- split window horizontally
vim.keymap.set("n", "<leader>se", "<C-w>=", opts) -- make split windows equal width & height
vim.keymap.set("n", "<leader>xs", ":close<CR>", opts) -- close current split window

-- Navigate between splits
vim.keymap.set("n", "<C-k>", ":wincmd k<CR>", opts)
vim.keymap.set("n", "<C-j>", ":wincmd j<CR>", opts)
vim.keymap.set("n", "<C-h>", ":wincmd h<CR>", opts)
vim.keymap.set("n", "<C-l>", ":wincmd l<CR>", opts)

-- Tabs
vim.keymap.set("n", "<leader>to", ":tabnew<CR>", opts) -- open new tab
vim.keymap.set("n", "<leader>tx", ":tabclose<CR>", opts) -- close current tab
vim.keymap.set("n", "<leader>tn", ":tabn<CR>", opts) --  go to next tab
vim.keymap.set("n", "<leader>tp", ":tabp<CR>", opts) --  go to previous tab

-- Toggle line wrapping
vim.keymap.set("n", "<leader>lw", "<cmd>set wrap!<CR>", opts)

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Keep last yanked when pasting
vim.keymap.set("v", "p", '"_dP', opts)

-- Diagnostic keymaps
vim.keymap.set("n", "[d", function()
	vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Go to previous diagnostic" })

vim.keymap.set("n", "]d", function()
	vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Go to next diagnostic" })

vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, {
	desc = "Open floating diagnostic message",
})

vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, {
	desc = "Open diagnostics list",
})

-- Move line down
vim.api.nvim_set_keymap("n", "<C-S-j>", ":m .+1<CR>==", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<C-S-j>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })

-- Move line up
vim.api.nvim_set_keymap("n", "<C-S-k>", ":m .-2<CR>==", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<C-S-k>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

-- Tmux Navigator keymaps
vim.keymap.set("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>", { desc = "Move to left split" })
vim.keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>", { desc = "Move to right split" })
vim.keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>", { desc = "Move to below split" })
vim.keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>", { desc = "Move to above split" })

-- Git diff keymaps
-- Open diff view (side-by-side like your screenshot)
vim.keymap.set("n", "<leader>gd", "<cmd>DiffviewOpen<CR>", {
	desc = "Git Diff (Diffview)",
})

-- Close diff view
vim.keymap.set("n", "<leader>gq", "<cmd>DiffviewClose<CR>", {
	desc = "Close Diffview",
})

-- File history
vim.keymap.set("n", "<leader>gh", "<cmd>DiffviewFileHistory<CR>", {
	desc = "Git File History",
})

-- JAVA KEYMAPS — fresh terminal each run (safe from terminal)

-- Store last "real file" buffer (not terminal/help/etc)
vim.g._java_last_file_buf = vim.g._java_last_file_buf or nil

vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		if vim.bo.buftype == "" then
			vim.g._java_last_file_buf = vim.api.nvim_get_current_buf()
		end
	end,
})

local function java_current_file_path()
	local buf = vim.g._java_last_file_buf
	if not buf or not vim.api.nvim_buf_is_valid(buf) then
		return nil
	end
	local name = vim.api.nvim_buf_get_name(buf)
	if name == "" or name:match("^term://") then
		return nil
	end
	return name
end

-- Store last Java run terminal buffer id
vim.g.java_run_term_buf = vim.g.java_run_term_buf or nil

local function close_java_term_if_exists()
	local buf = vim.g.java_run_term_buf
	if buf and vim.api.nvim_buf_is_valid(buf) then
		-- close windows that show it
		for _, win in ipairs(vim.api.nvim_list_wins()) do
			if vim.api.nvim_win_get_buf(win) == buf then
				vim.api.nvim_win_close(win, true)
			end
		end
		-- wipe buffer (kills terminal job)
		vim.api.nvim_buf_delete(buf, { force = true })
	end
	vim.g.java_run_term_buf = nil
end

local function open_fresh_java_term_and_run(cmd)
	close_java_term_if_exists()

	vim.cmd("botright split | resize 12 | terminal")
	local term_buf = vim.api.nvim_get_current_buf()
	vim.g.java_run_term_buf = term_buf

	local chan = vim.b.terminal_job_id
	if chan then
		vim.fn.chansend(chan, "clear\n" .. cmd .. "\n")
	end
end

-- Run current Java file (simple, no package)
vim.keymap.set("n", "<leader>jr", function()
	local file = java_current_file_path()
	if not file then
		vim.notify("No Java file detected. Focus a .java file first.", vim.log.levels.WARN)
		return
	end

	local dir = vim.fn.fnamemodify(file, ":h")
	local classname = vim.fn.fnamemodify(file, ":t:r")

	local cmd = string.format(
		"cd %s && javac %s && java %s",
		vim.fn.shellescape(dir),
		vim.fn.shellescape(file),
		vim.fn.shellescape(classname)
	)

	open_fresh_java_term_and_run(cmd)
end, { desc = "Java: compile & run (fresh terminal)" })

-- Run current Java file (supports `package ...;`)
vim.keymap.set("n", "<leader>jR", function()
	local file = java_current_file_path()
	if not file then
		vim.notify("No Java file detected. Focus a .java file first.", vim.log.levels.WARN)
		return
	end

	local dir = vim.fn.fnamemodify(file, ":h")

	-- detect package
	local pkg
	for _, line in ipairs(vim.fn.readfile(file)) do
		local m = line:match("^%s*package%s+([%w%.]+)%s*;")
		if m then
			pkg = m
			break
		end
	end

	local classname = vim.fn.fnamemodify(file, ":t:r")
	local runTarget = pkg and (pkg .. "." .. classname) or classname

	-- run from src root if under /src/
	local cwd = dir
	local srcIndex = cwd:find("/src/")
	if srcIndex then
		cwd = cwd:sub(1, srcIndex + 3)
	end

	local cmd = string.format(
		"cd %s && javac %s && java %s",
		vim.fn.shellescape(cwd),
		vim.fn.shellescape(file),
		vim.fn.shellescape(runTarget)
	)

	open_fresh_java_term_and_run(cmd)
end, { desc = "Java: compile & run (package aware, fresh terminal)" })

-- Explicit Java formatting via Conform
vim.keymap.set("n", "<leader>jf", function()
	require("conform").format({
		lsp_fallback = false,
		async = true,
		timeout_ms = 3000,
	})
end, { desc = "Java: format file" })
