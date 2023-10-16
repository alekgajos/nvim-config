return {
  { 
    "danymat/neogen", 
    dependencies = "nvim-treesitter/nvim-treesitter", 
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
    -- Uncomment next line if you want to follow only stable versions
    -- version = "*" 
  }
}

