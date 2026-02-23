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
        terminal = {
          split = 'left',
        },
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

    -- Toggle opencode between left split and fullscreen float
    local opencode_fullscreen = false
    vim.keymap.set({ 'n', 't' }, '<leader>p', function()
      opencode_fullscreen = not opencode_fullscreen
      local provider = require('opencode.config').provider
      if provider and provider.opts and provider.opts.win then
        if opencode_fullscreen then
          provider.opts.win.position = 'float'
          provider.opts.win.width = 1
          provider.opts.win.height = 1
        else
          provider.opts.win.position = 'left'
          provider.opts.win.width = nil
          provider.opts.win.height = nil
        end
        -- Close the current window and reopen with updated opts
        local win = provider:get()
        if win then
          win:close()
        end
        provider:start()
      end
    end, { desc = 'Toggle opencode fullscreen' })

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
