local M = {
  plugins = {
    {
      'akinsho/bufferline.nvim',
      version = '*',
      dependencies = { 'nvim-tree/nvim-web-devicons' },
      opts = {
        options = {
          indicator = {
            icon = '󰇝',
            style = 'icon',
          },
          max_name_length = 26,
          tab_size = 16,
          diagnostics = 'nvim_lsp',
          offsets = {
            {
              filetype = 'neo-tree',
              text = 'Neo-Tree',
              text_align = 'center',
              separator = true,
            },
          },
        },
      },
    },
  },
}

return M
