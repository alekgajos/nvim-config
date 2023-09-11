return {
	"folke/which-key.nvim",
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
        "pyproject.toml", "build.sbt", "CMakeLists.txt", "Cargo.toml" },
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
  },
}


