return {
  {
    'https://github.com/saifulapm/commasemi.nvim',
  },
  { -- Autoformat (conform.nvim)
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
  {
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
          --[[NOTE:
              For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
              https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
          --]]
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
        -- defaults: performance = { debounce = 60, throttle = 30, fetching_timeout = 500, filtering_context_budget = 3, confirm_resolve_timeout = 80, async_budget = 1, max_view_entries = 200, },
      }
    end,
  },
}
