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
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim', opts = {} },
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'j-hui/fidget.nvim', opts = {} },
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end
          --#TODO: Improve the leader keys for these lsp functions
          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          map('grf', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition', { 'n', 'x' })
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
          map('<leader>csb', require('telescope.builtin').lsp_document_symbols, '[S]ymbols in [b]uffer', { 'n', 'x' })
          map('<leader>csw', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[S]ymbols in [W]orkspace')
          map('<leader>r', vim.lsp.buf.rename, '[R]ename')
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          local client = vim.lsp.get_client_by_id(event.data.client_id)
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

          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map('<leader>th', function() --TODO: try this out, remove if don't like it
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      vim.diagnostic.config { --:help vim.diagnostic.Opts
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

      -- This doesn't do anything
      -- fuck off
      local servers = {
        basedpyright = {},
        pylsp = {},

        gopls = {
          --buildFlags = { '-tags=mage', 'mage' },
          standaloneTags = { 'ignore', 'mage' },
        },
        golangci_lint_ls = {},
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
        marksman = {},
      }

      local ensure_installed = vim.tbl_keys(servers or {}) -- Ensure the servers and tools above are installed

      vim.list_extend(ensure_installed, { 'stylua' }) -- Used to format Lua code. add more LSPs here, check w mason
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }
      require('mason-lspconfig').setup {
        ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
        automatic_installation = false,
        automatic_enable = { exclude = { 'markdown_oxide', 'golangci_lint_ls' } },
        handlers = {
          function(server_name)
            if server_name ~= 'gopls' then
              local server = servers[server_name] or {}
              server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
              require('lspconfig')[server_name].setup(server)
            end
          end,
          ['gopls'] = function() -- Specific handler for golang (gopls)
            local lspconfig = require 'lspconfig'
            lspconfig['gopls'].setup {
              capabilities = capabilities,
              settings = {
                gopls = {
                  buildFlags = { '-tags=mage' },
                  standaloneTags = { 'ignore', 'mage' },
                },
              },
            }
          end,
        },
      }
    end,
  },
}
