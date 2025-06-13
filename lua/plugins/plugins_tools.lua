return {
  { 'tpope/vim-sleuth' }, -- Detect tabstop/shiftwidth automatically
  { -- terminal
    'akinsho/toggleterm.nvim',
    version = '*',
    opts = {
      open_mapping = [[<C-\>]],
      persist_size = true,
      shell = 'nu',
      size = function(term)
        if term.direction == 'horizontal' then
          return 12
        elseif term.direction == 'vertical' then
          return vim.o.columns * 0.2
        end
      end,
    },
    config = true,
    lazy = false,
    -- trying to disable this to see if it makes the above mapping work from the start
  },

  {
    'willothy/wezterm.nvim',
    name = 'wezterm.nvim',
    config = true,
    opts = {
      create_commands = true,
    },
    lazy = true,
    --q: can we interact remote with wezterm?
    --cond = not vim.g.neovide,
  },
  { 'kazhala/close-buffers.nvim', opts = {} },
  {
    'willothy/flatten.nvim',
    config = true, -- or pass configuration with opts = {  }
    lazy = false,
    priority = 1001, -- Ensure that it runs first to minimize delay when opening file from terminal
  },

  { -- Scratch: Create general/language-specific scratch buffers
    'LintaoAmons/scratch.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    event = 'VeryLazy',
    keys = { { '<leader>us', '<cmd>Scratch<CR>', 'New Scratch Buffer' } },
    opts = {
      file_picker = 'telescope',
      filetypes = { 'lua', 'go', 'zig', 'python' },
      filetype_details = {
        go = {
          requireDir = true, -- true if each scratch file requires a new directory
          filename = 'main', -- the filename of the scratch file in the new directory
          content = { 'package main', '', 'func main() {', '  ', '}' },
          cursor = {
            location = { 4, 2 },
            insert_mode = true,
          },
        },
      },
      --filetype_details = {go = {...}} --* iffff go is acting weird, copy the section from helpfile to here
    },
  },
  { -- icon-picker: telescope picker for Nerd Fonts icons
    'ziontee113/icon-picker.nvim',
    config = function()
      local ip = require 'icon-picker'
      ip.setup { disable_legacy_commands = true }

      local opts = { noremap = true, silent = true }

      vim.keymap.set('n', '<Leader>ui', '<cmd>IconPickerNormal<cr>', opts)
      --vim.keymap.set('n', '<Leader><Leader>y', '<cmd>IconPickerYank<cr>', opts) --> Yank the selected icon into register
      vim.keymap.set('i', '<C-i>', '<cmd>IconPickerInsert<cr>', opts) --insert mode
    end,
  },
  {
    '2kabhishek/nerdy.nvim',
    -- going to exclusively use telescope; disable snacks dep
    --[[ dependencies = {
      'folke/snacks.nvim',
    }, ]]
    cmd = 'Nerdy',
  },
  { -- unicode picker: telescope picker for unicode symbols
    'cosmicboots/unicode_picker.nvim',
    dependencies = {
      'uga-rosa/utf8.nvim',
      'nvim-telescope/telescope.nvim',
    },
    opts = {},
  },
  {
    'uga-rosa/ccc.nvim',
    opts = {},
  },
  {
    'famiu/bufdelete.nvim',
    keys = {
      {
        '<leader><BS>',
        function()
          require('bufdelete').bufwipeout(0)
        end,
        desc = 'Bufdelete',
      },
      {
        '<C-Backspace>',
        function()
          require('bufdelete').bufdelete(0, true)
        end,
        desc = 'Bufdelete Forcibly',
      },
    },
  },
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {},
  },
}
