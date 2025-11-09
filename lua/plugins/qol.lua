local secretWin
return {
  { -- escape input mode with 'jk'
    'TheBlob42/houdini.nvim', --https://github.com/TheBlob42/houdini.nvim
    config = true,
  },
  { -- centers the current buffer in window
    -- Zen mode is good but this is also good for not losing outline and shit
    'shortcuts/no-neck-pain.nvim',
    config = true,
    opts = {
      -- width
      minSideBufferWidth = 06,
      buffers = {
        wo = { winfixwidth = true },
      },
      -- callbacks = {
      --   postEnable = function(state)
      --   end,
      -- },
    },
    cond = true,
  },
  { -- makes virtual text at pair close showing context
    -- I prefer this more as a vscode-ish top of screen navbar thing
    -- I know those exist. disabled for now
    'andersevenrud/nvim_context_vt',
    enabled = false,
  },
  -- Lua
  {
    'folke/zen-mode.nvim',
    opts = {
      -- ── RUN FUNCTIONS ON OPEN/CLOSE ZEN MODE ────────────────────────────
      --on_open = function(win) end,
      --on_close = function() end,
      -- ────────────────────────────────────────────────────────────────────
      window = {
        backdrop = 0.9,
        width = 0.68, -- 0.8 = 80% win width, 80 = 80 chars
      },
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
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
  -- {
  --   'smjonas/inc-rename.nvim',
  --   opts = {},
  -- },
}
