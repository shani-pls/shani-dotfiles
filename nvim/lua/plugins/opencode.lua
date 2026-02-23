return {
  'nickjvandyke/opencode.nvim',
  version = '*', -- Latest stable release
  dependencies = {
    {
      -- `snacks.nvim` integration is recommended, but optional
      ---@module "snacks" <- Loads `snacks.nvim` types for configuration intellisense
      'folke/snacks.nvim',
      opts = {
        input = {}, -- Enhances `ask()`
        picker = { -- Enhances `select()`
          actions = {
            opencode_send = function(...)
              return require('opencode').snacks_picker_send(...)
            end,
          },
          win = {
            input = {
              keys = {
                ['<a-a>'] = { 'opencode_send', mode = { 'n', 'i' } },
                ['<CR>'] = { 'opencode_send', mode = { 'n', 'i' } },
              },
            },
          },
        },
        terminal = {}, -- Enables the `snacks` provider
      },
    },
  },
  config = function()
    ---@type opencode.Opts
    vim.g.opencode_opts = {
      provider = {
        enabled = 'snacks',
        snacks = {
          win = {
            position = 'left',
          },
        },
      },
    }

    vim.o.autoread = true -- Required for `opts.events.reload`

    -- Recommended/example keymaps
    vim.keymap.set({ 'n', 'x' }, '<leader>l', function()
      require('opencode').toggle()
    end, { desc = 'Toggle opencode' })
    vim.keymap.set({ 'n', 'x' }, '<leader>la', function()
      require('opencode').ask('@this: ', { submit = true })
    end, { desc = 'Ask opencode with context' })
    vim.keymap.set({ 'n', 'x' }, '<C-x>', function()
      require('opencode').select()
    end, { desc = 'Execute opencode action…' })

    -- Toggle opencode split between normal and expanded width
    local opencode_expanded = false
    vim.keymap.set({ 'n', 'x' }, '<leader>p', function()
      local provider = require('opencode.config').provider
      if not provider then return end
      local win = provider:get()
      if not (win and win.win and vim.api.nvim_win_is_valid(win.win)) then return end
      opencode_expanded = not opencode_expanded
      local total = vim.o.columns
      local new_width = opencode_expanded and math.floor(total * 0.75) or math.floor(total * 0.35)
      vim.api.nvim_win_set_width(win.win, new_width)
    end, { desc = 'Toggle opencode expanded' })
    vim.keymap.set({ 'n', 'x' }, 'go', function()
      return require('opencode').operator '@this '
    end, { desc = 'Add range to opencode', expr = true })
    vim.keymap.set('n', 'goo', function()
      return require('opencode').operator '@this ' .. '_'
    end, { desc = 'Add line to opencode', expr = true })

    vim.keymap.set('n', '<S-C-u>', function()
      require('opencode').command 'session.half.page.up'
    end, { desc = 'Scroll opencode up' })
    vim.keymap.set('n', '<S-C-d>', function()
      require('opencode').command 'session.half.page.down'
    end, { desc = 'Scroll opencode down' })
  end,
}
