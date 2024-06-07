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

vim.opt.cursorline = true

-- disgnostics keymaps
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- fix Terraform filetype detection
vim.filetype.add({
  extension = {
    tf = "terraform"
  }
})

-- fix Treesitter not enabling highlight for Terraform
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
    pattern = "*.tf",
    callback = function()
      vim.cmd([[
        TSEnable highlight
      ]])
    end
  })
