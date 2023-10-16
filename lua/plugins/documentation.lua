return {
  { 
    "danymat/neogen", 
    dependencies = "nvim-treesitter/nvim-treesitter", 
    keys = {
      {"<leader>dg", "<cmd>:Neogen<cr>", desc = "Docstring generate"}
    },
    opts = {
      enabled = true,
      languages = {
        python = {
          template = {
            annotation_convention = "google_docstrings",
          },
        },
      }
    },
    config = true,
  }
}

