-- TODO:
-- [ ] redo groups of keymaps with which-key
-- [ ] split into the plugins/ directory
-- [x] neogen
-- [ ] DAP
-- [x] snacks-indent
-- [ ] Minuet AI
-- [ ] Clangd toggle source header
-- [ ] Check what else is needed for completion with 0.12
-- [ ] Fugitive?
-- [ ] Check out diffview

vim.g.mapleader = " "
vim.o.relativenumber = true
vim.o.number = true
vim.o.signcolumn = "yes"
vim.opt.cursorline = true

-- jk and jk as Escape
local options = { noremap = true }
vim.keymap.set("i", "jk", "<Esc>", options)
vim.keymap.set("i", "kj", "<Esc>", options)

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- no tabs!
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.number = true
vim.opt.relativenumber = true

-- colorscheme
vim.pack.add({
  "https://github.com/navarasu/onedark.nvim",
})
require('onedark').setup {
  style = 'darker'
}
require('onedark').load()

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


require("toggleterm").setup({ direction = "float" })

vim.keymap.set("n", "<C-\\>", '<Cmd>ToggleTerm<CR>')
vim.keymap.set("t", "<C-\\>", '<Cmd>ToggleTerm<CR>')

-- which-key
vim.pack.add({
  { src = "https://github.com/folke/which-key.nvim" },
})


-- -- LSP
vim.lsp.enable({
  'clangd',
  'zls',
  'rust_analyzer',
  'basedpyright',
  'lua_ls',
})


vim.lsp.config('clangd', {
  cmd = {
    "clangd",
    "--completion-style=detailed",
    "--header-insertion=never",
  },
})

vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { desc = "Code Actions" })
vim.keymap.set("x", "<leader>la", vim.lsp.buf.code_action, { desc = "Code Actions" })
vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, { desc = "LSP Rename" })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })
vim.keymap.set("n", "<leader>lh", vim.lsp.buf.signature_help, { desc = "Signature help" })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Goto Definition" })
vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "Format" })
vim.keymap.set("n", "<leader>lic", vim.lsp.buf.incoming_calls, { desc = "LSP Incoming Calls" })
vim.keymap.set("n", "<leader>loc", vim.lsp.buf.outgoing_calls, { desc = "LSP Outgoing Calls" })
vim.keymap.set("n", "grr", vim.lsp.buf.references, { desc = "vim.lsp.buf.references()" })
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "vim.lsp.buf.implementation()" })
vim.keymap.set("n", "gO", vim.lsp.buf.document_symbol, { desc = "LSP Document Symbol" })
vim.keymap.set("n", "<leader>ly", vim.lsp.buf.typehierarchy, { desc = "LSP Type Hierarchy" })
vim.keymap.set("n", "<leader>lt", function() require("telescope.builtin").lsp_references() end,
  { desc = "Telescope References" })


--

local function augroup(name)
  return vim.api.nvim_create_augroup("user_" .. name, { clear = true })
end

local completion = vim.g.completion_mode or "blink" -- or 'native' for built-in completion
vim.api.nvim_create_autocmd("LspAttach", {
  group = augroup("lsp_attach"),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local buf = args.buf
    if client then
      -- Built-in completion
      if completion == "native" and client:supports_method("textDocument/completion") then
        vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
        --
        local bufopts = { noremap = true, silent = true, buffer = ev.buf }
        map("n", "grd", vim.lsp.buf.definition, bufopts)
        map("i", "<C-k>", vim.lsp.completion.get, bufopts) -- open completion menu manually
      end

      -- Inlay hints
      if client:supports_method("textDocument/inlayHint") then
        vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
      end

      if client:supports_method("textDocument/documentColor") then
        vim.lsp.document_color.enable(true, { bufnr = buf }, {
          style = "virtual",
        })
      end
    end
  end,
})


--

-- TODO: Document outline

-- Treesitter
vim.pack.add({ { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" } }, { confirm = false })

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

-- Outline
vim.pack.add({
  { src = "https://github.com/hedyhli/outline.nvim" },
  { src = "https://github.com/stevearc/aerial.nvim" },
})

vim.keymap.set("n", "<leader>lS", "<cmd>Outline<CR>", { desc = "LSP Outline" })

require("outline").setup({
  symbol_folding = {
    autofold_depth = 2,
  }
})

require("aerial").setup({
  on_attach = function(bufnr)
    vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
    vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
    vim.keymap.set("n", "<leader>lA", "<cmd>AerialToggle<CR>", { buffer = bufnr })
  end,
})

-- Telescope alternative
vim.pack.add({
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/nvim-telescope/telescope.nvim" }
})

require("telescope").setup(

  {
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
  })

local wk = require("which-key")
wk.add({
  { "<leader>f",  group = "Telescope" }, -- group
  { "<leader>ff", "<cmd>Telescope find_files<cr>",           desc = "find file" },
  { "<leader>fw", "<cmd>Telescope live_grep<cr>",            desc = "live grep" },
  { "<leader>fG", "<cmd>Telescope grep_string<cr>",          desc = "grep string" },
  { "<leader>fb", "<cmd>Telescope buffers<cr>",              desc = "buffers" },
  { "<leader>fk", "<cmd>Telescope registers<cr>",            desc = "registers" },
  { "<leader>fr", "<cmd>Telescope lsp_references<cr>",       desc = "references" },
  { "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", desc = "symbols" },
  { "<leader>fq", "<cmd>Telescope quickfix<cr>",             desc = "quickfix" },
  { "<leader>fd", "<cmd>Telescope diagnostics<cr>",          desc = "diagnostics" },
  { "<leader>fh", "<cmd>Telescope help_tags<cr>",            desc = "help" },
  { "<leader>fc", "<cmd>Telescope commands<cr>",             desc = "commands" },
  { "<leader>fC", "<cmd>Telescope colorscheme<cr>",          desc = "colorschemes" },
})

-- lualine
vim.pack.add({
  { src = "https://github.com/nvim-lualine/lualine.nvim" }
})

require("lualine").setup({
  options = {
    component_separators = "",
    icons_enabled = true,
    section_separators = { left = "", right = "" },
    theme = "nord",
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { { "filename", file_status = true, path = 1 } },
    lualine_c = { { "branch", icon = "" } },
    lualine_x = { "filetype" },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
  tabline = {
    lualine_a = { "buffers" },
  },
}
)

-- neogen
vim.pack.add({
  { src = "https://github.com/danymat/neogen" }
})

require("neogen").setup({
  enabled = true,
  languages = {
    python = {
      template = {
        annotation_convention = "google_docstrings",
      },
    },
  },
}
)

vim.keymap.set("n", "<leader>dg", "<cmd>Neogen<CR>", { desc = "Docstring generate" })

-- snacks
vim.pack.add({
  { src = "https://github.com/folke/snacks.nvim" }
})

require("snacks").setup({
  indent = {
    priority = 1,
    enabled = true,
    char = "│",
    only_scope = false,
    only_current = false,
    hl = "SnacksIndent",
  },
})


-- Minuet
vim.pack.add({
  { src = "https://github.com/milanglacier/minuet-ai.nvim" }
})
require('minuet').setup {

  -- virtualtext = {
  --   auto_trigger_ft = { 'python', },
  --   keymap = {
  --     -- accept whole completion
  --     accept = '<A-A>',
  --     -- accept one line
  --     accept_line = '<A-a>',
  --     -- accept n lines (prompts for number)
  --     -- e.g. "A-z 2 CR" will accept 2 lines
  --     accept_n_lines = '<A-z>',
  --     -- Cycle to prev completion item, or manually invoke completion
  --     prev = '<A-[>',
  --     -- Cycle to next completion item, or manually invoke completion
  --     next = '<A-]>',
  --     dismiss = '<A-e>',
  --   },
  -- },

  provider = "codestral",

  -- provider_options = {
  --
  --
  --   codestral = {
  --     model = 'codestral-latest',
  --     end_point = 'https://codestral.mistral.ai/v1/fim/completions',
  --     api_key = 'CODESTRAL_API_KEY',
  --     stream = true,
  --      template = {
  --           prompt = function(context_before_cursor, context_after_cursor, opts) end,
  --           suffix = function(context_before_cursor, context_after_cursor, opts) end,
  --       },
  --     -- template = {
  --     --   prompt = "See [Prompt Section for default value]",
  --     --   suffix = "See [Prompt Section for default value]",
  --     -- },
  --     optional = {
  --       stop = { '\n\n' },
  --       max_tokens = 256,
  --     },
  --   },
  -- },
  -- ui = {
  --   virtualtext = true,
  -- },
}

-- blink
vim.pack.add({
  { src = "https://github.com/Saghen/blink.cmp", version = "v1.6.0" },
})
require("blink.cmp").setup({
  keymap = { preset = 'default' },
  appearance = {
    nerd_font_variant = 'mono'
  },
  completion = { documentation = { auto_show = true } },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer', },
    -- providers = {
    --   minuet = {
    --     name = 'minuet',
    --     module = 'minuet.blink',
    --     async = true,
    --     -- Should match minuet.config.request_timeout * 1000,
    --     -- since minuet.config.request_timeout is in seconds
    --     timeout_ms = 3000,
    --     score_offset = 50, -- Gives minuet higher priority among suggestions
    --   },
    -- },
  },
  fuzzy = { implementation = "prefer_rust" },
  keymap = {
    ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
    ["<Up>"] = { "select_prev", "fallback" },
    ["<Down>"] = { "select_next", "fallback" },
    ["<C-N>"] = { "select_next", "show" },
    ["<C-P>"] = { "select_prev", "show" },
    ["<C-J>"] = { "select_next", "fallback" },
    ["<C-K>"] = { "select_prev", "fallback" },
    ["<C-U>"] = { "scroll_documentation_up", "fallback" },
    ["<C-D>"] = { "scroll_documentation_down", "fallback" },
    ["<C-e>"] = { "hide", "fallback" },
    ["<CR>"] = { "accept", "fallback" },
    ["<Tab>"] = {
      "select_next",
      "snippet_forward",
      function(cmp)
        if has_words_before() or vim.api.nvim_get_mode().mode == "c" then return cmp.show() end
      end,
      "fallback",
    },
    ["<S-Tab>"] = {
      "select_prev",
      "snippet_backward",
      function(cmp)
        if vim.api.nvim_get_mode().mode == "c" then return cmp.show() end
      end,
      "fallback",
    },
  },
})

vim.keymap.set("i", "<C-j>", require('minuet').make_blink_map)
