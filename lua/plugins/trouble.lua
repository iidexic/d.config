return {
  {
    'folke/trouble.nvim',
    opts = {
      warn_no_results = false,
      win = { size = { width = 60, height = 12 } }, -- default for bottom/right; per-mode overrides below
      modes = {
        symbols = { win = { position = 'right', size = { width = 60 } } },
        lsp = { win = { position = 'right', size = { width = 70 } } },
      },
    },
    cmd = 'Trouble',
    keys = { -- Made all of these silent. I can guess that nothing was found if a window doesn't appear
      {
        '<leader>xX',
        '<cmd>sil Trouble diagnostics toggle<cr>',
        desc = 'All Buffers Diagnostics (Trouble)',
      },
      {
        '<leader>xx',
        '<cmd>sil Trouble diagnostics toggle filter.buf=0<cr>',
        desc = 'Buffer Diagnostics (Trouble)',
      },
      {
        '<leader>xs',
        '<cmd>sil Trouble symbols toggle focus=false<cr>',
        desc = 'Symbols (Trouble)',
      },
      {
        '<leader>xl',
        '<cmd>sil Trouble lsp toggle focus=false win.position=right<cr>',
        desc = 'LSP Definitions / references / ... (Trouble)',
      },
      --[[ {
        -- Overwriting quickfix button with loclist
        '<leader>q',
        '<cmd>sil Trouble loclist toggle<cr>',
        desc = 'Location List (Trouble)',
      }, ]]
      {
        '<leader>Q',
        '<cmd>sil Trouble qflist toggle<cr>',
        desc = 'Quickfix List (Trouble)',
      },
      {
        '<leader>X',
        '<cmd>sil Trouble<cr>',
        desc = 'Trouble tool picker',
      },
    },
  },
}
