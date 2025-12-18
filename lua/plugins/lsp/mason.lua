-- TODO:!!!!! SUPER HIGH: ENSURE NVIM-LSPCONFIG INSTALLED BEFORE MASON-LSPCONFIG
return {
  { -- LSP Plugins
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        { 'nvim-dap-ui' },
      },
    },
  },
  { -- [nvim-lspconfig] - Main LSP Configuration
    'mason-org/mason-lspconfig.nvim',
    dependencies = {
      -- { 'mason-org/mason.nvim', opts = { log_level = vim.log.levels.DEBUG } },
      { 'mason-org/mason.nvim', opts = {} },
      { 'j-hui/fidget.nvim', opts = {} },
      'saghen/blink.cmp',
      { 'neovim/nvim-lspconfig' },
    },
    config = function()
      require('settings.autocommands_lsp').make_autocommands()
      require('settings.vimconfig').lsp_diagnostic()
      -- local capabilities = vim.lsp.protocol.make_client_capabilities()
      -- NOTE: Try 'keep' if shit is still broken
      -- capabilities = vim.tbl_deep_extend('keep', {}, capabilities, require('cmp_nvim_lsp').default_capabilities())

      local servers = {
        -- ── go ──────────────────────────────────────────────────────────────
        gopls = {
          settings = {
            gopls = {
              buildFlags = { '-tags=mage' },
              standaloneTags = { 'ignore', 'mage' },
            },
          },
        },
        golangci_lint_ls = {},
        -- ── lua ─────────────────────────────────────────────────────────────
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              diagnostics = { globals = { 'vim' } },
            },
          },
        },
        stylua = {},
        -- ── markdown ────────────────────────────────────────────────────────
        marksman = {},
        -- ── c/cpp/zig ───────────────────────────────────────────────────────
        clangd = {},
        zls = {},
      }

      local ensure_installed = vim.tbl_keys(servers or {}) -- Ensure the servers and tools above are installed
      require('mason-lspconfig').setup {
        ensure_installed = ensure_installed or {},
        automatic_installation = true,
        automatic_enable = false,
      }

      -- ── MASON V2 SETUP ────────────────────────────────────────────────────────
      --  NOTE: Before or after?
      for name, config in pairs(servers) do
        --NOTE: Apparrently don't need capabilities now? IDK whatever
        -- config.capabilities = vim.tbl_deep_extend('force', {}, capabilities, config.capabilities or {})
        -- -- for ufo:
        -- config.capabilities = vim.tbl_deep_extend( 'force', {}, capabilities, { textDocument = { foldingRange = { dynamicRegistration = true, lineFoldingOnly = true } } })
        vim.lsp.config(name, config)
        vim.lsp.enable(name)
      end
    end,
  },
}
