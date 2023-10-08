-- jk and jk as Escape
local options = { noremap = true }
vim.keymap.set("i", "jk", "<Esc>", options)
vim.keymap.set("i", "kj", "<Esc>", options)

-- no tabs!
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "number"
