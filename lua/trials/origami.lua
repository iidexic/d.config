local M = {}
M.plugins = {
  {
    'chrisgrieser/nvim-origami',
    event = 'VeryLazy',
    opts = {}, -- needed even when using default config
    -- fixing auto-folding in vimconfig
  },
}

return M.plugins
