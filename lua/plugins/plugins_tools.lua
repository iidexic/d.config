local M = {}
M.plugins = {
  { 'tpope/vim-sleuth' }, -- Detect tabstop/shiftwidth automatically
  { -- terminal
    'akinsho/toggleterm.nvim',
    version = '*',
    opts = {
      open_mapping = [[<C-\>]],
      persist_size = true,
      shell = 'nu',
      direction = 'float',
      size = function(term)
        if term.direction == 'horizontal' then
          return vim.o.lines * 0.2
        elseif term.direction == 'vertical' then
          return vim.o.columns * 0.2
        else
          return 0.4
        end
      end,
      float_opts = {
        border = 'curved', --'single','double','shadow',or other options supported by win open
        width = function()
          return math.floor(vim.o.columns * 0.8)
        end,
        height = function()
          return math.floor(vim.o.lines * 0.8)
        end,
      },
    },

    --lazy = false,
  },

  {
    'willothy/wezterm.nvim',
    name = 'wezterm.nvim',
    cond = not vim.g.neovide,
    config = true,
    opts = {
      create_commands = true,
    },
    lazy = true,
    --q: can we interact remote with wezterm?
    --cond = not vim.g.neovide,
  },
  --WARNING: enabled 9-5, disable/remove if issues
  { 'kazhala/close-buffers.nvim', opts = {}, cond = true },
  {
    'willothy/flatten.nvim',
    config = true, -- or pass configuration with opts = {  }
    lazy = false,
    priority = 1001, -- Ensure that it runs first to minimize delay when opening file from terminal
  },
  {
    'glepnir/nerdicons.nvim',
    cmd = 'NerdIcons',
    opts = {},
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
    'romus204/referencer.nvim',
    opts = {
      enable = true,
      format = '  %d reference(s)',
      pattern = '*.go',
    },
    config = true,
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

--TODO: When new-mappings implemented: change M.setup2 to M.setup
M.setup2 = function()
  function _G.ttmap()
    local opts = { buffer = 0 }
    vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
    --vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts) I think this making lazygit shit work bad
    vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts) --{ '<Esc><Esc>', '<C-\\><C-n>' }--wtf is this
    vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
    vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
    vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
    vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
    -- works only when term not selected/not open?
    --opts.desc = 'ToggleTermFlip' --vim.keymap.set('t', '<M-\\>', toggletermFlip, opts)
  end
  -- if you only want these mappings for toggle term use term://*toggleterm#* instead
  vim.cmd 'autocmd! TermOpen term://* lua ttmap()'
end

return M
