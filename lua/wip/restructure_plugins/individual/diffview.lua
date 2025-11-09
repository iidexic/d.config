local M = {}
M.plugins = {
  -- covered by neogit, but need configure and want it with or without neogit
  {
    'sindrets/diffview.nvim',
    -- if this does not work, use autocommands on diffview's user events view_enter, view_leave
    opts = {
      keymaps = {
        disable_defaults = false,

        view = {
          { 'n', 'q', '<cmd>DiffviewClose<CR>', { desc = 'Close Diffview' } },
        },
        panel = {
          { 'n', '<esc><esc>', '<cmd>DiffviewClose<CR>', { desc = 'Close Diffview' } },
          { 'n', 'q', '<cmd>DiffviewClose<CR>', { desc = 'Close Diffview' } },
        },
      },
    },
  },
}

return M
