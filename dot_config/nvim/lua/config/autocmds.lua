-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Auto-reload buffers when files are changed outside Neovim (e.g. by Claude Code).
vim.opt.autoread = true

local external_edit_group = vim.api.nvim_create_augroup("user_external_file_changes", { clear = true })

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI", "TermClose", "TermLeave" }, {
	group = external_edit_group,
	callback = function()
		if vim.o.buftype ~= "" then
			return
		end
		if vim.fn.mode() == "c" then
			return
		end
		vim.cmd("checktime")
	end,
})

vim.api.nvim_create_autocmd("FileChangedShellPost", {
	group = external_edit_group,
	callback = function()
		vim.notify("File reloaded from disk (external change detected)", vim.log.levels.INFO)
	end,
})
