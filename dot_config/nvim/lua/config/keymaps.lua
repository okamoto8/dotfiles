-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- <Cmd>を使うとモード切り替えが不要で高速
vim.keymap.set("n", "<leader>Ra", "<Cmd>checktime<CR>", {
    desc = "Reload all changed files",
    silent = true,  -- コマンドライン表示を抑制
  })
  
  vim.keymap.set("n", "<leader>Rc", "<Cmd>edit!<CR>", {
    desc = "Reload current file (force)",
    silent = true,
  })