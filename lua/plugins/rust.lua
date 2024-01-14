return {
  "simrat39/rust-tools.nvim",
  ft = { "rust" },

  config = function()

    local opts = {
      tools = { -- rust-tools options
        autoSetHints = true,
        inlay_hints = {
          show_parameter_hints = false,
          parameter_hints_prefix = "",
          other_hints_prefix = "",
        },
      },

      server = {
        settings = {
          -- to enable rust-analyzer settings visit:
          -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
          ["rust-analyzer"] = {
            -- enable clippy on save
            checkOnSave = {
              command = "clippy"
            },
          }
        },
        on_attach = function(_, bufnr)
          local rt = require("rust-tools")
          vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
          -- Code action groups
          vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
        end
      },
    }

    require('rust-tools').setup(opts)

    --
    -- rt.setup({
      --   server = {
        --     on_attach = function(_, bufnr)
          --       -- Hover actions
          --     end,
          --   },
          -- }) 
        end



      }
