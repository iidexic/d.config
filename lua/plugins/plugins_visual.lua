return {
  --# Comments
  { -- Highlight todo, notes, etc in comments
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },
  {
    'danymat/neogen',
    config = true,
    -- version = "*" -- Uncomment for only stable versions
  },
  { -- nicer floating window/picker ui. try out some time
    'stevearc/dressing.nvim',
    cond = false,
  },
  {
    'rachartier/tiny-devicons-auto-colors.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    event = 'VeryLazy',
    config = function()
      require('tiny-devicons-auto-colors').setup()
    end,
  },

  {
    'soemre/commentless.nvim',
    cmd = 'Commentless',
    keys = {
      {
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
    opts = {
      -- Customize Configuration
    },
  },
  -- Fancy Comment Formatting - boxes, separators, all that good stuff
  {
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
