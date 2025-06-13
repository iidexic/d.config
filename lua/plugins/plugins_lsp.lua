return {
  { -- LSP Plugins
    'folke/lazydev.nvim', -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins. used for completion, annotations and signatures of Neovim apis
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        { 'nvim-dap-ui' },
      },
    },
  },
  { -- [nvim-lspconfig] - Main LSP Configuration
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim', opts = {} }, -- Automatically install LSPs and related tools to stdpath for Neovim
      -- Mason must be loaded before its dependents so we need to set it up here.
      -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      { 'j-hui/fidget.nvim', opts = {} }, -- Useful status updates for LSP.
      'hrsh7th/cmp-nvim-lsp', -- Allows extra capabilities provided by nvim-cmp
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', { --| LSP = Language Server Protocol. It's a protocol that helps editors
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end
          --#TODO: Improve the leader keys for these lsp functions
          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition') -- Jump to definition of word under cursor. To jump back, press <C-t>.
          map('grf', require('telescope.builtin').lsp_references, '[G]oto [R]eferences') -- Find references for the word under your cursor.
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition', { 'n', 'x' }) -- Jump to the type of the word under your cursor.
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' }) -- usually need cursor on lsp message
          map('<leader>csb', require('telescope.builtin').lsp_document_symbols, '[S]ymbols in [b]uffer', { 'n', 'x' }) -- Fuzzy find all the symbols in your current document.
          map('<leader>csw', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[S]ymbols in [W]orkspace') -- Fuzzy find all the symbols in your current workspace.
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame') -- Rename the variable under your cursor
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          --- Removed client_supports_method, intended to bridge a gap between nvim 0.10 and 0.11; see notes.fake.lua, lines 515 to 527 for original function

          local client = vim.lsp.get_client_by_id(event.data.client_id) -- next 2 used to highlight references of word under cursor on idle. See `:help CursorHold`
          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- The following code creates a keymap to toggle inlay hints in your code, if the language server you are using supports them.
          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map('<leader>th', function() --TODO: try this out, remove if don't like it
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      vim.diagnostic.config { -- Diagnostic Config See :help vim.diagnostic.Opts
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        } or {},
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
      }

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      local servers = { -- Enable the following language servers
        -- clangd = {},  pyright = {}, rust_analyzer = {}, -- `:help lspconfig-all` to see all preconfigured LSP
        --# Python ──────────────────────────────────────────────────────────
        ruff = { init_options = {
          configuration = 'C:/dev/.config/lsp/ruff.toml',
        } },
        basedpyright = {},
        pylsp = {},
        sourcery = {},
        --# Golang ──────────────────────────────────────────────────────────
        gopls = {},
        golangci_lint_ls = {},
        --# Lua ─────────────────────────────────────────────────────────────
        lua_ls = { -- cmd = { ... }, -- filetypes = { ... }, -- capabilities = {},
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              diagnostics = {}, --disable = { 'trailing-space' }
              -- diagnostics = { disable = { 'missing-fields' } }, -- toggle to ignore Lua_LS `missing-fields` warnings
            },
          },
        },
        --# Zig ─────────────────────────────────────────────────────────────
        --zls = {},
        --# Other ───────────────────────────────────────────────────────────
        marksman = {},
      }

      local ensure_installed = vim.tbl_keys(servers or {}) -- Ensure the servers and tools above are installed
      --- Trying to make sure ruff is set up?
      --- Is this necessary?
      vim.lsp.config('ruff', { init_options = { settings = {} } })

      vim.list_extend(ensure_installed, { 'stylua' }) -- Used to format Lua code. add more LSPs here, check w mason
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }
      require('mason-lspconfig').setup {
        ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
        automatic_installation = false,
        automatic_enable = { exclude = { 'markdown_oxide', 'golangci_lint_ls' } },
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- Handles overriding values passed by server config above. Useful for disabling unwanted LSP features
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },
}
