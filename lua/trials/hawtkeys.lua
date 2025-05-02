return {
  {
    'tris203/hawtkeys.nvim', --https://github.com/tris203/hawtkeys.nvim
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    config = {
      -- for lazy "keys = {}" compatibility
      ['lazy'] = {
        method = 'lazy',
      },
    },
  },
}
