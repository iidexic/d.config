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
      {
        '<leader>C',
        function()
          local commentless = require 'commentless'
          local ok_ufo, ufo = pcall(require, 'ufo')
          local win = vim.api.nvim_get_current_win()
          local buf = vim.api.nvim_get_current_buf()
          vim.w[win].commentless_saved = vim.w[win].commentless_saved
            or { foldlevel = vim.wo[win].foldlevel, foldminlines = vim.wo[win].foldminlines }
          if commentless.is_hidden() then
            commentless.toggle() -- reveal
            local saved = vim.w[win].commentless_saved or {}
            vim.wo[win].foldlevel = saved.foldlevel or 99
            vim.wo[win].foldminlines = saved.foldminlines or 1
            vim.w[win].commentless_saved = nil
            if ok_ufo then pcall(ufo.attach, buf) end
          else
            if ok_ufo then pcall(ufo.detach, buf) end
            vim.wo[win].foldmethod = 'expr'
            vim.wo[win].foldexpr = "v:lua.require'commentless.internal'.foldexpr()"
            vim.wo[win].foldlevel = 0
            vim.wo[win].foldminlines = 0
            commentless.toggle() -- hide (runs zx)
          end
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
