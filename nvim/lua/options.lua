-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_tutor_mode_plugin = 1

vim.g.have_nerd_font = true

vim.o.cmdheight = 0
vim.o.showcmd = false

-- [[ Highlight Groups ]]
vim.api.nvim_set_hl(0, 'TelescopeBorder', { fg = '#ca9ee6' })
vim.api.nvim_set_hl(0, 'TelescopePromptBorder', { fg = '#ca9ee6' })
vim.api.nvim_set_hl(0, 'TelescopePreviewBorder', { fg = '#ca9ee6' })
vim.api.nvim_set_hl(0, 'TelescopeResultBorder', { fg = '#ca9ee6' })
vim.api.nvim_set_hl(0, 'TelescopeResultsBorder', { fg = '#ca9ee6' })
vim.api.nvim_set_hl(0, 'TelescopeSelectionBorder', { fg = '#ca9ee6' })
vim.api.nvim_set_hl(0, 'NeoTreeFloatTitle', { fg = '#ca9ee6' })
vim.api.nvim_set_hl(0, 'NeoTreeFloatBorder', { fg = '#ca9ee6' })
vim.api.nvim_set_hl(0, 'NeoTreeFloatBorder', { fg = '#ca9ee6' })
vim.api.nvim_set_hl(0, '@lsp.type.enumMember', { fg = '#ca9ee6' })

-- [[ Setting options ]]
local opt = vim.opt

opt.number = true

opt.mouse = 'a'

opt.showmode = false -- Don't show the mode, since it's already in the status line

-- custom options
opt.whichwrap = 'hl'

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
vim.schedule(function()
  opt.clipboard = 'unnamedplus'
end)

opt.breakindent = true

opt.undofile = true -- Save undo history

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
opt.ignorecase = true
opt.smartcase = true

-- Keep signcolumn on by default
opt.signcolumn = 'yes'

-- Decrease update time
opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
opt.timeoutlen = 300

-- Configure how new splits should be opened
opt.splitright = true
opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
opt.list = false
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
opt.inccommand = 'split'

-- Show which line your cursor is on
opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
opt.scrolloff = 10

-- true colors for terminal
opt.termguicolors = true

-- [[ Basic Autocommands ]]
-- Highlight when yanking text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

-- Open Neo-tree on VimEnter
vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    require('neo-tree.command').execute { action = 'show' }
  end,
})

vim.api.nvim_create_autocmd('BufEnter', {
  group = vim.api.nvim_create_augroup('Neotree_start_directory', { clear = true }),
  desc = 'Start Neo-tree with directory',
  once = true,
  callback = function()
    if package.loaded['neo-tree'] then
      return
    else
      local stats = vim.uv.fs_stat(vim.fn.argv(0))
      if stats and stats.type == 'directory' then
        require 'neo-tree'
      end
    end
  end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.go',
  callback = function()
    local params = vim.lsp.util.make_range_params()
    params.context = { only = { 'source.organizeImports' } }
    -- buf_request_sync defaults to a 1000ms timeout. Depending on your
    -- machine and codebase, you may want longer. Add an additional
    -- argument after params if you find that you have to write the file
    -- twice for changes to be saved.
    -- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
    local result = vim.lsp.buf_request_sync(0, 'textDocument/codeAction', params)
    for cid, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or 'utf-16'
          vim.lsp.util.apply_workspace_edit(r.edit, enc)
        end
      end
    end
    vim.lsp.buf.format { async = false }
  end,
})
