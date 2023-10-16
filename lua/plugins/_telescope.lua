return {
	'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  lazy = false,
	keys = {
		{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "find file" },
		{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "live grep" },
		{ "<leader>fG", "<cmd>Telescope grep_string<cr>", desc = "grep string" },
		{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "buffers" },
		{ "<leader>fk", "<cmd>Telescope registers<cr>", desc = "registers" },
		{ "<leader>fr", "<cmd>Telescope lsp_references<cr>", desc = "references" },
		{ "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", desc = "symbols" },
		{ "<leader>fq", "<cmd>Telescope quickfix<cr>", desc = "quickfix" },
		{ "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "diagnostics" },
		{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "help" },
		{ "<leader>fc", "<cmd>Telescope commands<cr>", desc = "commands" },
		{ "<leader>fC", "<cmd>Telescope colorscheme<cr>", desc = "colorschemes" },
	},	

	config = function()
		require("telescope").setup {
			file_ignore_patterns = { "^target/", "^./.git/", "^build/", "^.cache/" },
      defaults = {
        preview = {
          treesitter = false
        },
        layout_strategy = "flex",
        layout_config = {
          flip_columns = 200,
        }
      }
		}
	end
}
