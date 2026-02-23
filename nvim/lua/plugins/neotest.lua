return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      { 'fredrikaverpil/neotest-golang', version = '*' },
    },
    -- stylua: ignore
    keys = {
        { "<leader>tr", function() require("neotest").run.run() end,                                         desc = "run test" },
        { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end,                       desc = "run file tests" },
        { "<leader>td", function() require("neotest").run.run({ strategy = "dap" }) end,                     desc = "run test with dap" },
        { "<leader>to", function() require("neotest").output.open({ enter = true }) end,                     desc = "open test output" },
        { "<leader>tw", function() require("neotest").watch.toggle(vim.fn.expand("%")) end,                  desc = "toggle watch test" },
        { "<leader>tp", function() require("neotest").output_panel.toggle() end,                             desc = "open test output panel" },
        { "<leader>tt", function() require("neotest").summary.toggle() end,                                  desc = "open summary test panel" },
    },
    config = function()
      local config = { -- Specify configuration
        runner = 'gotestsum',
        go_test_args = {
          '-v',
          '-race',
          '-count=1',
          '-coverprofile=' .. vim.fn.getcwd() .. '/coverage.out',
        },
      }
      require('neotest').setup {
        icons = {
          expanded = '',
          child_prefix = '',
          child_indent = '',
          final_child_prefix = '',
          non_collapsible = '',
          collapsed = '',

          passed = '',
          running = '',
          failed = '',
          unknown = '',
        },
        adapters = {
          require 'neotest-golang'(config), -- Apply configuration
        },
        output = {
          enabled = true,
          open_on_run = 'short',
        },
        output_panel = {
          enabled = true,
          open = 'botright split | resize 15',
        },
      }

      -- Setup keybinding to close Neotest output with 'q'
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'neotest-output',
        callback = function()
          vim.api.nvim_buf_set_keymap(0, 'n', 'q', '<cmd>q<CR>', { noremap = true, silent = true })
        end,
      })
    end,
  },
}
