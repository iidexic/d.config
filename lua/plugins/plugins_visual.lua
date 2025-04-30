return {
  --# Comments
  { -- Highlight todo, notes, etc in comments
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },
  {
    'soemre/commentless.nvim',
    cmd = 'Commentless',
    keys = {
      {
        '<leader>/',
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
  { 'LudoPinelli/comment-box.nvim' },
  { -- Commenting Plugin: Comment Toggling, regex ignore, other useful stuff
    'numToStr/Comment.nvim',
    opts = {
      -- add any options here
    },
  },

  --# Colors
  { 'HiPhish/rainbow-delimiters.nvim' },
}
