return {
  -- which-key
  {"folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 200
  end,
  -- note: opts must be there, even if empty
  --       otherwise setup would not be called!
  opts = {}
},
  -- comment.nvim
	{
		'numToStr/Comment.nvim',
		config = function()
			require("Comment").setup()
		end
	},
  -- project.nvm
	{
		"ahmedkhalf/project.nvim",
		config = function()
			require('project_nvim').setup {
				detection_methods = { "lsp", "pattern" },
				patterns = { ".git", "compile_commands.json", "compile_flags.txt", ".project", "makefile", "Makefile",
        "pyproject.toml", "build.sbt", "Cargo.toml" },
				manual_mode = false,
			}
		end
	},
  -- themes
  {
    "RRethy/nvim-base16",
  },
  {
    "navarasu/onedark.nvim",
    lazy = false,
    init = function()
      require('onedark').setup()
      vim.cmd([[colorscheme onedark]])
    end
  },
}


