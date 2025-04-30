--- Main Kickstart Plugin list
-- make this a function if desired
return {
  --* NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).

  { --> plugins_tools
    -- Detect tabstop and shiftwidth automatically
    'tpope/vim-sleuth',
  },
  { --> plugins_git
    --[gitsigns] - Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = { add = { text = '+' }, change = { text = '~' }, delete = { text = '_' }, topdelete = { text = '‾' }, changedelete = { text = '~' } },
    },
  },
  { --> plugins_keys
    --[which-key] - Show pending keybinds/motion completions
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = {
      delay = 0, -- delay between pressing a key and opening which-key (milliseconds) (independent of vim.opt.timeoutlen)
      icons = {
        mappings = vim.g.have_nerd_font, -- if nerd font use default map. which-key uses nf by default
        keys = vim.g.have_nerd_font and {} or { -- otherwise use these
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },
      spec = { -- Document existing key chains:
        { '<leader>c', group = '[A]pp' },
        { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
        { [[<C-\>]], group = 'ToggleTerm' },
      },
    },
  },
  { --> plugins_lsp
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
  { --> plugins_lsp
    -- [nvim-lspconfig] - Main LSP Configuration
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim', opts = {} }, -- Automatically install LSPs and related tools to stdpath for Neovim
      -- Mason must be loaded before its dependents so we need to set it up here. * NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
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

          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition') -- gd - Jump to definition of word under cursor. To jump back, press <C-t>.
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences') -- gr - Find references for the word under your cursor.
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation') -- gI - Jump to the implementation of the word under your cursor.
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition') --* `[L]D` - Jump to the type of the word under your cursor.
          map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols') -- `[L]ds` - Fuzzy find all the symbols in your current document.
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols') -- `[L]ws` - Fuzzy find all the symbols in your current workspace.
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame') -- `[L]rn` - Rename the variable under your cursor. Most LSP support renaming across files, etc.
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' }) -- `[L]ca` - Execute a code action, usually need cursor on top of an error or suggestion from your LSP for this to activate.
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration') -- gD - WARN: Goto Declaration (not Definition)

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
        -- clangd = {}, gopls = {}, pyright = {}, rust_analyzer = {}, -- `:help lspconfig-all` to see all preconfigured LSP
        lua_ls = {
          -- cmd = { ... }, -- filetypes = { ... }, -- capabilities = {},
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              -- diagnostics = { disable = { 'missing-fields' } }, -- toggle to ignore Lua_LS `missing-fields` warnings
            },
          },
        },
      }

      local ensure_installed = vim.tbl_keys(servers or {}) -- Ensure the servers and tools above are installed

      vim.list_extend(ensure_installed, { 'stylua' }) -- Used to format Lua code. add more LSPs here, check w mason
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }
      require('mason-lspconfig').setup {
        ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
        automatic_installation = false,
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
  { --> plugins_auto
    -- Autoformat (conform.nvim)
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        local disable_filetypes = { c = true, cpp = true }
        local lsp_format_opt
        if disable_filetypes[vim.bo[bufnr].filetype] then
          lsp_format_opt = 'never'
        else
          lsp_format_opt = 'fallback'
        end
        return {
          timeout_ms = 500,
          lsp_format = lsp_format_opt,
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        go = { 'gopls' },
        python = { 'ruff' },
        -- python = { "isort", "black", stop_after_first = true }, stop_after_first(optional) = load first available
      },
    },
  },

  { --> plugins_auto
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {

      { -- Snippet Engine & its associated nvim-cmp source
        'L3MON4D3/LuaSnip',
        build = (function() -- Build Step is needed for regex support in snippets. Windows usually not supported
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then -- Remove this condition to re-enable on windows.
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          {
            'rafamadriz/friendly-snippets',
            config = function()
              require('luasnip.loaders.from_vscode').lazy_load()
            end,
          },
        },
      },
      'lukas-reineke/cmp-under-comparator', -- personal one, intended to make completions a bit better when underscores are involved
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp', -- adds other completion capabilities. next 2 lines are included with this
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lsp-signature-help',
    },
    config = function()
      local cmp = require 'cmp' -- see `:help cmp`
      local luasnip = require 'luasnip'
      luasnip.config.setup {}
      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = 'menu,menuone,noinsert' },
        mapping = cmp.mapping.preset.insert { --`:help ins-completion` for info on why these mappings chosen
          ['<c-n>'] = cmp.mapping.select_next_item(), -- select the [n]ext item
          ['<c-p>'] = cmp.mapping.select_prev_item(), -- select the [p]revious item
          ['<C-b>'] = cmp.mapping.scroll_docs(-4), -- scroll the documentation window [b]ack / [f]orward
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          --['<C-y>'] = cmp.mapping.confirm { select = true }, -- accept[y] the completion (will expand snippets from lsp). this auto-imports if lsp supports it.
          --['<C-,>'] = cmp.mapping.select_prev_item(),
          --['<C-.>'] = cmp.mapping.select_next_item(),
          ['<C-CR>'] = cmp.mapping.confirm { select = true },
          --========[ If you prefer more traditional completion keymaps: ]========--
          --['<CR>'] = cmp.mapping.confirm { select = true },
          --['<Tab>'] = cmp.mapping.select_next_item(), -- you can uncomment the following lines
          --['<S-Tab>'] = cmp.mapping.select_prev_item(),

          ['<C-Space>'] = cmp.mapping.complete {}, -- Manually trigger a completion from nvim-cmp. (these auto-display so generally not needed)
          ['<C-l>'] = cmp.mapping(function() -- move to right of each of the expansion locations.
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function() -- <c-h> is similar, except moving you backwards.
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),

          -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
          --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
        },
        sources = {
          {
            name = 'lazydev',
            group_index = 0, -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
          },
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
          { name = 'nvim_lsp_signature_help' },
        },
        -- defaults
        -- performance = { debounce = 60, throttle = 30, fetching_timeout = 500, filtering_context_budget = 3, confirm_resolve_timeout = 80, async_budget = 1, max_view_entries = 200, },
        --formatting = {} -- second try to adjust
        --Third try. Also doesn't work?? idk man. the option certainly exists though
        --window = { completion = { scrolloff = 6 } },
      }
    end,
  },
  --> plugins_comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } }, -- Highlight todo, notes, etc in comments

  { --> treesitters
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts = {
      ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
      auto_install = true, -- Autoinstall languages that are not installed
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'ruby' }, --  for indent problems, add lang to list of additional_vim_regex_highlighting and disabled languages for indent.
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
  },

  --  Here are some example plugins that I've included in the Kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  -- require 'kickstart.plugins.debug',
  -- require 'kickstart.plugins.indent_line',
  -- require 'kickstart.plugins.lint',
  -- require 'kickstart.plugins.autopairs'
  -- require 'kickstart.plugins.neo-tree',
  -- require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps

  --* NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --{ import = 'custom.plugins' }, --  add your plugins to `lua/custom/plugins/*.lua` to get going.
}
