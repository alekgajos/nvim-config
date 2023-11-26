return {
  "akinsho/toggleterm.nvim",
  lazy = false,
  opts = {
    size = 120,
    open_mapping = [[<c-\>]],
    hide_numbers = true,
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = true,
    insert_mappings = true,
    persist_size = true,
    direction = "float",
    close_on_exit = false,
    shell = vim.o.shell,
    float_opts = {
      border = "curved",
      winblend = 0,
      highlights = {
        border = "Normal",
        background = "Normal",
      },
    },
  },
  keys = {
    {"<leader>tl", "<cmd>:ToggleTermSendCurrentLine<cr>", desc = "Term send current line"},
    {"<leader>tl", "<cmd>:ToggleTermSendVisualLines<cr>", mode="v", desc = "Term send visual lines"},
    {"<leader>tv", "<cmd>:ToggleTermSendVisualSelection<cr>", mode="v", desc = "Term send visual seletion"},
  }
}
