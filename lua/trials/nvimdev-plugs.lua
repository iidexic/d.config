local M = {}

M.plugins = {
  { -- lspsaga provides much nicer lsp interactivity and visualization
    'nvimdev/lspsaga.nvim',
    config = function()
      require('lspsaga').setup {}
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter', -- optional
      'nvim-tree/nvim-web-devicons', -- optional
    },
  },
  -- nerdicons: a search window for nerd font icons
  -- no longer necessary. Using icon picker
  --[[ {
    'glepnir/nerdicons.nvim',
    cmd = 'NerdIcons',
    config = function()
      require('nerdicons').setup {}
    end,
  },]]

  { -- a nice neovim dashboard
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require('dashboard').setup {
        -- config
      }
    end,
    dependencies = { { 'nvim-tree/nvim-web-devicons' } },
  },
}

return M.plugins
