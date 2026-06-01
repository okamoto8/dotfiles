-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.lazyvim_picker = "telescope"

-- 外部変更の自動リロード設定
vim.opt.autoread = true

-- Local fallback: if Dart is not on PATH, use ~/flutter/bin when present.
do
	local flutter_bin = vim.fn.expand("~") .. "/flutter/bin"
	if vim.fn.executable("dart") == 0 and vim.fn.isdirectory(flutter_bin) == 1 then
		vim.env.PATH = flutter_bin .. ":" .. vim.env.PATH
	end
end
