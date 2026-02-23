return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    require('bufferline').setup {
      options = {
        separator_style = 'slant',
      },
    }

    vim.keymap.set('n', '<leader>ts', '<CMD>BufferLinePickClose<CR>')
    vim.keymap.set('n', '<Tab>k', '<CMD>BufferLineCycleNext<CR>')
    vim.keymap.set('n', '<Tab>j', '<CMD>BufferLineCyclePrev<CR>')
    vim.keymap.set('n', ']b', '<CMD>BufferLineMoveNext<CR>')
    vim.keymap.set('n', '[b', '<CMD>BufferLineMovePrev<CR>')
  end,
}
