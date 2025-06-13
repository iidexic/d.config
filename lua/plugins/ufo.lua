--- Originally just took AstroNvim's UFO setup. It's too Astro-ey
local M = {}
M.plugins = {
  {
    'kevinhwang91/nvim-ufo',
    -- will adding lspconfig here ensure it runs first?
    dependencies = { 'kevinhwang91/promise-async', 'neovim/nvim-lspconfig' },
    -- moved to config so can disable and not get the rebinds
    -- plugin loader setup does not have that capaability yet
    cond = true,
    config = function()
      local ufo = require 'ufo'
      vim.keymap.set('n', 'zR', ufo.openAllFolds)
      vim.keymap.set('n', 'zM', ufo.closeAllFolds)
      -- Option 2: nvim lsp as LSP client
      -- Tell the server the capability of foldingRange. Neovim hasn't added foldingRange to default capabilities, users must add it manually
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = true, -- false? I dunno. This was originally false
        lineFoldingOnly = true,
      }
      local language_servers = vim.lsp.get_clients() -- or list servers manually like {'gopls', 'clangd'}
      for _, ls in ipairs(language_servers) do
        require('lspconfig')[ls].setup {
          capabilities = capabilities,
          -- you can add other fields for setting up lsp server in this table
        }
      end
      require('ufo').setup()
    end,
  },
}

return M
