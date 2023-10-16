return
{
  {
  "mfussenegger/nvim-lint",
  ft = {"cpp", "python"},
  config=function()

    require('lint').linters_by_ft = {
      cpp = { "cppcheck" },
      python = {"pylint"}
    }
    local cppcheck = require('lint').linters.cppcheck
    cppcheck.args = {
      '--enable=warning,style,performance,information',
      '--language=c++',
      '--inline-suppr',
      '--cppcheck-build-dir=.cppcheck-build',
      '--template={file}:{line}:{column}: [{id}] {severity}: {message}'
    }

    vim.api.nvim_create_autocmd({'BufWritePre', 'InsertLeave'}, {
      pattern = '',
      callback = function()

        -- ensure the cppcheck build dir exists
        local Path = require("plenary.path")
        local expected_build_dir = Path:new(vim.loop.cwd(), ".cppcheck-build")
        if not expected_build_dir:exists() then
          print("creating .cppcheck-build directory") 
          expected_build_dir:mkdir()
        end

        local lint_status, lint = pcall(require, "lint")
        if lint_status then
          lint.try_lint()
        end
      end,
    })
  end
},
{
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    {"<leader>tt", "<cmd>:TroubleToggle document_diagnostics<cr>", desc="TroubleToggle"}
  },
  opts = {},
}
}


