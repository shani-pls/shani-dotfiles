-- -- Neo-tree is a Neovim plugin to browse the file system
-- -- https://github.com/nvim-neo-tree/neo-tree.nvim
--
return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { ' e', ':Neotree toggle<CR>', desc = '[E]xplorer', silent = true },
    { ' r', ':Neotree reveal<CR>', desc = '[R]eveal', silent = true },
  },
  opts = {
    popup_border_style = 'rounded',
    default_component_configs = {
      diagnostics = {
        symbols = {
          hint = '',
          info = '',
          warn = '',
          error = '',
        },
        highlights = {
          hint = 'DiagnosticSignHint',
          info = 'DiagnosticSignInfo',
          warn = 'DiagnosticSignWarn',
          error = 'DiagnosticSignError',
        },
      },
    },
    window = {
      position = 'right',
      -- popup = { -- settings that apply to float position only
      --   size = { height = '80%', width = 70 },
      --   position = '50%', -- 50% means center it
      --   padding = 15,
      -- },
      width = 70,
      mapping_options = {
        noremap = true,
        nowait = true,
      },
      mappings = {
        ['<space>'] = {
          'toggle_node',
          nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
        },
        ['<2-LeftMouse>'] = 'open',
        ['<cr>'] = 'open',
        ['<esc>'] = 'cancel', -- close preview or floating neo-tree window
        ['P'] = { 'toggle_preview', config = { use_float = true, use_image_nvim = true } },
        -- Read `# Preview Mode` for more information
        ['l'] = 'open',
        ['h'] = 'close_node',
        ['S'] = 'open_split',
        ['s'] = 'open_vsplit',
        -- ["S"] = "split_with_window_picker",
        -- ["s"] = "vsplit_with_window_picker",
        ['t'] = 'open_tabnew',
        -- ["<cr>"] = "open_drop",
        -- ["t"] = "open_tab_drop",
        ['w'] = 'open_with_window_picker',
        --["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
        ['C'] = 'close_node',
        -- ['C'] = 'close_all_subnodes',
        ['z'] = 'close_all_nodes',
        --["Z"] = "expand_all_nodes",
        ['a'] = {
          'add',
          -- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
          -- some commands may take optional config options, see `:h neo-tree-mappings` for details
          config = {
            show_path = 'none', -- "none", "relative", "absolute"
          },
        },
        ['A'] = 'add_directory', -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
        ['d'] = 'delete',
        ['r'] = 'rename',
        ['y'] = 'copy_to_clipboard',
        ['x'] = 'cut_to_clipboard',
        ['p'] = 'paste_from_clipboard',
        ['c'] = 'copy', -- takes text input for destination, also accepts the optional config.show_path option like "add":
        -- ["c"] = {
        --  "copy",
        --  config = {
        --    show_path = "none" -- "none", "relative", "absolute"
        --  }
        --}
        ['m'] = 'move', -- takes text input for destination, also accepts the optional config.show_path option like "add".
        -- ['q'] = 'close_window',
        ['R'] = 'refresh',
        ['?'] = 'show_help',
        ['<Tab>'] = 'prev_source',
        ['<S-Tab>'] = 'next_source',
        ['i'] = 'show_file_details',
      },
    },
    -- filesystem = {
    --   mappings = {
    --     ['q'] = 'close_window',
    --   },
    -- },
  },
}
