return {
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    opts = {
      inlay_hints = {enabled = true},
    },
    config = function()
      require('lspconfig')['clangd'].setup({})
      require('lspconfig')['rust_analyzer'].setup({})
      require('lspconfig')['pyright'].setup({})
      require('lspconfig')['dockerls'].setup({})
    end,

    keys = {
      { "gd", vim.lsp.buf.definition, desc = "LSP goto definition" },
      { "gD", vim.lsp.buf.declaration, desc = "LSP goto declaration" },
      { "gi", vim.lsp.buf.implementation, desc = "LSP goto implementation" },
      { "K", vim.lsp.buf.hover, desc = "LSP hover" },
      { "<C-k>", vim.lsp.buf.signature_help, desc = "LSP signature help" },
      { "gR", vim.lsp.buf.rename, desc = "LSP rename" },
      { "gr", vim.lsp.buf.references, desc = "LSP references" },
      { "<space>h", ":ClangdSwitchSourceHeader<CR>", desc = "LSP toggle header/source" },
      { "<space>f", function()
        vim.lsp.buf.format(nil, 200)
      end,
      desc = "LSP format" },
    }

  },
  -- completion
  {
  'hrsh7th/nvim-cmp',
  config = function()
    local cmp = require('cmp')
    local luasnip = require("luasnip")

    local has_words_before = function()
      unpack = unpack or table.unpack
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    cmp.setup({
      snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
          require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        end,
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.

        ["<Tab>"] = cmp.mapping(function(fallback)

          if cmp.visible() then
            cmp.select_next_item()
            -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable() 
            -- that way you will only jump inside the snippet region
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' }, -- For luasnip users.
        { name = 'path' }}, 
        {{ name = 'buffer' },}
        )
      })
    end
  
  },
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
  'saadparwaiz1/cmp_luasnip',
  -- snippets
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end
  },
  {
    "rafamadriz/friendly-snippets",
    lazy = true,
  },
}
