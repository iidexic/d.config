local M = {
  plugins = {
    {
      'MeanderingProgrammer/render-markdown.nvim',
      dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
      ---@module 'render-markdown'
      ---@type render.md.UserConfig
      opts = {},
    },
    {
      'OXY2DEV/markview.nvim',
      lazy = false,
      cond = false,
      opts = { preview = { icon_provider = 'devicons' } },
      -- For blink.cmp's completion
      -- source
      -- dependencies = {
      --     "saghen/blink.cmp"
      -- },
    },
  },
}

return M
