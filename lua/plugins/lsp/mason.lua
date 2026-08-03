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
        -- ── markdown ────────────────────────────────────────────────────────
        marksman = {},
        -- ── Python ──────────────────────────────────────────────────────────
        basedpyright = {},
        -- ── c/cpp/zig ───────────────────────────────────────────────────────
        clangd = {},
        -- zls = {},
        -- NOTE: powershell_es removed — windows-only, and mason kept failing to
        -- install it here. Re-add on the windows box if wanted.
        buf_ls = {},
      }

      -- These are all installed through npm. Without node/npm on PATH mason
      -- retries (and fails) every single startup, so only ask for them if the
      -- machine can actually build them.
      if vim.fn.executable 'npm' == 1 then
        -- ── THE REST WOO ──────────────────────────────────────────────────
        servers.vtsls = {}
        -- dartls is set up by flutter-tools.nvim — do not duplicate here
        servers.tailwindcss = {}
        servers.svelte = {}
      end

      local ensure_installed = vim.tbl_keys(servers)
      require('mason-lspconfig').setup {
        ensure_installed = ensure_installed,
        automatic_installation = true,
        automatic_enable = false,
      }

      -- NOTE: godotdev is NOT an lsp config -- godotdev.nvim ships no
      -- lsp/godotdev.lua, it wires up its own client from lua/godotdev/lsp.lua.
      -- Registering it here produced
      --   invalid "godotdev" config: cmd: expected ... got nil
      -- in the lsp log on every buffer open. Its options now live in
      -- plugins/godot.lua where the plugin actually reads them.

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
