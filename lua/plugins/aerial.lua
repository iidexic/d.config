local M = {
  {
    'stevearc/aerial.nvim',
    opts = {
      -- layout = { },
      -- attach_mode = "global", -- default "window", global will change to show active buffer
      on_attach = function(bufnr)
        -- Jump forwards/backwards with '{' and '}'
        vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', { buffer = bufnr })
        vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', { buffer = bufnr })
      end,
    },
    -- Optional dependencies
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
    --vim.keymap.set('n', '<leader>o', '<cmd>AerialToggle!<CR>')
  },
}

return M
