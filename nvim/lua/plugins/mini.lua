return { -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  config = function()
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
    --  - ci'  - [C]hange [I]nside [']quote
    require('mini.ai').setup { n_lines = 500 }

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    require('mini.surround').setup()

    -- Setup for mini statusline
    local statusline = require 'mini.statusline'

    -- Custom setup
    statusline.setup {
      use_icons = vim.g.have_nerd_font,
      content = {
        -- Left section: Remove section_mode (the test tube icon) and section_windows (e.g., H5)
        '%=',
        -- Middle section: Display filename
        statusline.section_filename,
        -- Right section: Line:Column and Percentage
        '%=',
        statusline.section_location, -- Custom line:column with percentage
      },
    }

    -- Custom function for line:column and percentage
    statusline.section_location = function()
      local line = vim.fn.line '.'
      local col = vim.fn.virtcol '.'
      local total_lines = vim.fn.line '$'
      local percentage = math.floor((line / total_lines) * 100)
      return string.format('%2d:%-2d %d%%%%', line, col, percentage)
    end
  end,
}
