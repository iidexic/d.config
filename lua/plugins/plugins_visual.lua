return {
  {
    'nvim-tree/nvim-web-devicons',
    opts = {
      override_by_filename = {
        ['go'] = {
          icon = '󰟓 ',
          color = '#1a90d6',
          -- name = 'Gitignore',
        },
      },
    },
  },
  --# Comments
  { -- Highlight todo, notes, etc in comments
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },
  { -- TODO: Add a mapping to generate annotations
    'danymat/neogen',
    config = true,
    opts = {
      languages = { 'go', 'lua', 'python' },
    },
    -- version = "*" -- Uncomment for only stable versions
  },
  { -- nicer floating window/picker ui. (Has it been in use?)
    'stevearc/dressing.nvim',
    enabled = true,
  },

  {
    'soemre/commentless.nvim',
    cmd = 'Commentless',
    keys = {
      { -- just add this to keymaps
        '<leader>\\',
        function()
          require('commentless').toggle()
        end,
        desc = 'Toggle Comments',
      },
    },
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {},
  },
  { -- Fancy Comment Formatting - boxes, separators, all that good stuff
    'LudoPinelli/comment-box.nvim',
  },
  { -- Commenting Plugin: Comment Toggling, regex ignore, other useful stuff
    'numToStr/Comment.nvim',
    opts = {
      -- add any options here
    },
  },

  --# Colors
  -- Trying to update this just crashed my nvim.
  -- check back in later if having it seems helpful
  --{ 'HiPhish/rainbow-delimiters.nvim' },
}
