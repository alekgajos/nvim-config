return {
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    opts = {
      inlay_hints = {enabled = true},
    },
    config = function()
      require('lspconfig')['clangd'].setup({})
    end,

    keys = {
      { "gd", vim.lsp.buf.definition, desc = "LSP goto definition" },
      { "gD", vim.lsp.buf.declaration, desc = "LSP goto declaration" },
      { "gi", vim.lsp.buf.implementation, desc = "LSP goto implementation" },
      { "K", vim.lsp.buf.hover, desc = "LSP hover" },
      { "<C-k>", vim.lsp.buf.signature_help, desc = "LSP signature help" },
      { "gR", vim.lsp.buf.rename, desc = "LSP rename" },
      { "gr", vim.lsp.buf.references, desc = "LSP references" },
      { "gD", vim.lsp.buf.implementation, desc = "LSP goto implementation" },
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
  'hrsh7th/cmp-cmdline'

}
