vim.g.mapleader = " "
vim.o.relativenumber = true
vim.o.number = true
vim.o.signcolumn = "yes"
vim.opt.cursorline = true

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- diagnostics
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = " ",
      [vim.diagnostic.severity.HINT] = " ",
    },
  },
  virtual_text = true, -- show inline diagnostics
})

vim.pack.add({
	{ src = "https://github.com/akinsho/toggleterm.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
})

require("toggleterm").setup({direction = "float"})

vim.keymap.set("n", "<C-\\>", '<Cmd>ToggleTerm<CR>')
vim.keymap.set("t", "<C-\\>", '<Cmd>ToggleTerm<CR>')

-- LSP
vim.lsp.enable("zls")

-- Treesitter
vim.pack.add({ {src="https://github.com/nvim-treesitter/nvim-treesitter", version="main"} }, { confirm = false })

-- equivalent to :TSUpdate
require("nvim-treesitter.install").update("all")

require("nvim-treesitter").setup({
  auto_install = true,
})

require("nvim-treesitter").install({
	"bash",
	"c",
	"diff",
	"dockerfile",
	"html",
	"ini",
	"json",
	"lua",
	"luadoc",
	"markdown",
	"nix",
	"python",
	"rust",
	"toml",
	"xml",
	"yaml",
	"zig",
})
