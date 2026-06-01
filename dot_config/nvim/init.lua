-- Flutter PATH
vim.env.PATH = vim.env.HOME .. "/flutter/bin:" .. vim.env.PATH

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")