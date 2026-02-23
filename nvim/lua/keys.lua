-- Remove default vim stuff
vim.keymap.set('n', 's', '<nop>') -- Disable default `s` mapping

-- Prevent leader key (Space) from triggering in insert mode
vim.keymap.set('i', '<Space>', '<Space>', { noremap = true })

-- Better escape
vim.keymap.set('i', 'jk', '<Esc>')
vim.keymap.set('i', 'kj', '<Esc>')

-- Comment and uncomment
vim.keymap.set({ 'n' }, '<leader>/', 'gcc', { desc = 'Toggle Comment', remap = true }) -- Use with leader n to comment n lines
vim.keymap.set({ 'v' }, '<leader>/', 'gc', { desc = 'Toggle Comment', remap = true }) -- Use with leader n to comment n lines

-- HOP
vim.keymap.set('n', 'sm', ':lua vim.lsp.buf.hover()<cr>', { desc = '[S]how [M]ore' })
vim.keymap.set('n', 'se', ':lua vim.diagnostic.open_float()<cr>', { desc = '[S]how [E]rror' })
vim.keymap.set('n', 'ne', ':lua vim.diagnostic.goto_next()<cr>', { desc = '[N]ext [E]rror' })
-- lvim.keys.normal_mode["sw"] = "<cmd>HopWord<cr>"
vim.keymap.set('n', '<leader>fg', ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")

-- Modify files
vim.keymap.set('n', '<leader>bd', '<cmd>bdelete<CR><cmd>bnext<CR>', { desc = '[B]uffer [D]elete and move next' })
vim.keymap.set('n', '<leader>w', '<cmd>w<CR>', { desc = '[F]ile [W]rite' })
vim.keymap.set('n', '<leader>q', '<cmd>q<CR>', { desc = '[F]ile [Q]uit' })

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- better navigation
vim.keymap.set('n', 'G', 'Gzz', { desc = 'Go to end of line and center it' })

vim.keymap.set('v', 'p', '"_dP', { desc = 'Paste from system register' })

-- indentation
vim.keymap.set('v', '>', '>gv', { desc = 'Indent selected lines' })
vim.keymap.set('v', '<', '<gv', { desc = 'Unindent selected lines' })

-- Terminal mode scrolling
vim.keymap.set('t', '<C-k>', '<C-\\><C-n><C-u>i', { desc = 'Scroll up in terminal' })
vim.keymap.set('t', '<C-j>', '<C-\\><C-n><C-d>i', { desc = 'Scroll down in terminal' })

-- Open last modified file
vim.keymap.set('n', '<leader>fm', function()
  local handle = io.popen('ls -t ~/.config/nvim/**/*.lua | head -1')
  if handle then
    local file = handle:read('*a'):gsub('%s+', '')
    handle:close()
    if file ~= '' then
      vim.cmd('edit ' .. file)
    end
  end
end, { desc = '[F]ind [M]ost recently modified file' })