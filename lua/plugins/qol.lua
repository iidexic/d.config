return {
  { -- centers the current buffer in window. I Use both this and zen mode
    'shortcuts/no-neck-pain.nvim',
    config = true,
    opts = {
      width = 120,
      minSideBufferWidth = 4,
      buffers = {
        wo = { winfixwidth = true },
      },
      -- callbacks = { postEnable = function(state) end, },
    },
    cond = true,
  },
  {
    'folke/zen-mode.nvim',
    opts = {
      --on_open = function(win) end, -- runs on start zen mode
      --on_close = function() end, -- runs on exit zen mode
      window = {
        backdrop = 0.9,
        width = 0.68, -- 0.8 = 80% win width, 80 = 80 chars
      },
      -- your config comes here
      plugins = {
        options = {
          enabled = true,
        },
        neovide = {
          enabled = true, --automatically checks vim.g.neovide
          -- Will multiply the current scale factor by this number
          scale = 1.04,
          -- disable the Neovide animations while in Zen mode
          disable_animations = false,
          --[[{
            neovide_animation_length = 0,
            neovide_cursor_animate_command_line = false,
            neovide_scroll_animation_length = 0,
            neovide_position_animation_length = 0,
            neovide_cursor_animation_length = 0,
            neovide_cursor_vfx_mode = '',
          },
          --]]
        },
      },
    },
  },
}
