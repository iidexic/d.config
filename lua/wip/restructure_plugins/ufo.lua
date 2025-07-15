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
      -- ╭─────────────────────────────────────────────────────────╮
      -- │  NOTE: Currently testing using both lsp and treesitter  │
      -- │             as fold provider simultaneously             │
      -- ╰─────────────────────────────────────────────────────────╯
      -- for the time being this has worked; will update if run into problems

      -- ── Option 2: nvim lsp as provider ────────────────────────────────
      -- Tell the server the capability of foldingRange. Neovim hasn't added foldingRange to default capabilities, users must add it manually
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = true, -- false? I dunno. This was originally false
        lineFoldingOnly = true,
      }
      local language_servers = vim.lsp.get_clients() -- or list servers {'gopls', 'clangd'}
      for _, ls in ipairs(language_servers) do
        require('lspconfig')[ls].setup {
          capabilities = capabilities,
        } -- you can add other fields for setting up lsp server in this table
      end
      --require('ufo').setup()
      -- ── Treesitter as provider ──────────────────────────────────────────
      require('ufo').setup {
        provider_selector = function(bufnr, filetype, buftype)
          return { 'treesitter', 'indent' }
        end,
      }
    end,
  },
}

return M
