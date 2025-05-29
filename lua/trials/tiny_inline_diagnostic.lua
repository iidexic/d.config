return {
  { --NOTE: Check config function before enable!:
    ---- vim.diagnostic.config({ virtual_text = false })
    -- (if our diagnostic messages are from built-in, otherwise will be doubled up or cause issues)
    'rachartier/tiny-inline-diagnostic.nvim',
    event = 'VeryLazy', -- Or `LspAttach`
    priority = 1000, -- needs to be loaded in first
    config = function()
      require('tiny-inline-diagnostic').setup()
      vim.diagnostic.config { virtual_text = false } -- Only if needed in your configuration, if you already have native LSP diagnostics
    end,
  },
}
