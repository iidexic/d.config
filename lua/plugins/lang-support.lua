return {
  -- ───────────────────────────────[Flutter/Dart]──────────────────────────────────────
  {
    'nvim-flutter/flutter-tools.nvim',
    ft = { 'dart' },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
    opts = {
      -- widget_guides + outline auto_open are both off, so we don't need the
      -- server pushing flutterOutline/outline notifications on every keystroke.
      lsp = {
        color = { enabled = false }, -- avoid the deprecated document-color path on 0.12+
        settings = {
          -- flutter-tools nests this under `dart` before sending to dartls
          showTodos = false,
          completeFunctionCalls = true,
          renameFilesWithClasses = 'prompt',
          updateImportsOnRename = true,
          -- Skip generated/build output when analyzing — huge win in projects
          -- that use freezed / json_serializable / build_runner.
          analysisExcludedFolders = {
            '.dart_tool',
            '.fvm',
            'build',
            '.pub-cache',
          },
        },
        init_options = {
          onlyAnalyzeProjectsWithOpenFiles = true,
          suggestFromUnimportedLibraries = true,
          closingLabels = true,
          outline = false,        -- flutter-tools outline pane isn't auto-opened
          flutterOutline = false, -- widget_guides is disabled, so this is dead data
        },
      },
    },
  },
  -- ────────────────────────────────[ Other ]──────────────────────────────
  {
    -- runs python code. I am guessing it prefers hydrogen format
    -- the readme says may only be usable if using vimscript config files.
    'smzm/hydrovim',
    dependencies = { 'MunifTanjim/nui.nvim' },
    enabled = false,
  },
  {
    'alexpasmantier/pymple.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      -- optional (nicer ui)
      'stevearc/dressing.nvim', -- currently enabled
      'nvim-tree/nvim-web-devicons',
    },
    build = ':PympleBuild',
    opts = {
      keymaps = {
        -- auto finds/adds the import (for what cursor is on) to top of file (below any doctsring)
        resolve_import_under_cursor = {
          desc = 'Resolve import under cursor',
          keys = '<leader>li', -- may do this later in mapping file
        },
      },
    },
    enabled = false,
  },
  -- ────────────────────────────────[ Zig ]────────────────────────────────
  { 'ziglang/zig.vim', cond = false },

  -- ────────────────────────────────[ Go ]─────────────────────────────────

  {
    'ray-x/go.nvim',
    dependencies = { -- optional packages
      'ray-x/guihua.lua',
      'neovim/nvim-lspconfig',
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {
      -- lsp_keymaps = false,
    },
    config = function(_, opts)
      require('go').setup(opts)
      vim.api.nvim_create_autocmd('BufWritePre', {
        pattern = '*.go',
        group = vim.api.nvim_create_augroup('GoFormat', { clear = true }),
        callback = function()
          require('go.format').goimports()
        end,
      })
    end,
    event = { 'CmdlineEnter' },
    ft = { 'go', 'gomod' },
    -- NOTE: removed sync build hook (:lua require("go.install").update_all_sync()).
    -- It blocked nvim on Lazy update. Run :GoInstallBinaries manually instead.
  },

  --TODO: Need to choose between goplements and gosigns? one is gutter.
  -- could probably use both. not sure if gosigns is going to be actually useful

  { -- visual display of interface implementation next to struct declaration
    'maxandron/goplements.nvim',
    enabled = true,
    ft = 'go',
    opts = {},
  },
  { -- visualize interface+struct+method implementation, and //go: comments. Very customizable
    'Yu-Leo/gosigns.nvim',
    cond = false,
    ft = 'go',
    cmd = { 'GosignsEnable', 'GosignsDisable', 'GosignsToggle' },
    opts = {}, -- for default options. Refer to the configuration section for custom setup.
  },
  -- ────────────────────────────────[ Lua ]────────────────────────────────
  { -- lua scratchpad, interactive repl type deal
    'rafcamlet/nvim-luapad',
    dependencies = 'antoinemadec/FixCursorHold.nvim',
    keys = { { '<leader>ul', '<cmd>Luapad<CR>', desc = '[L]uapad' } },
    opts = {
      count_limit = 100000,
      eval_on_change = true, -- change this to disable auto-eval
      --on_init = function() end --not sure what default does, if  any

      -- ── luapad globals defenitions ──────────────────────────────────────
      context = {
        vim = vim,
        t = { --#FOLD---------------
          dict = { one = 1, two = 2, three = '3', five = 'nan', four = nil },
          list = { 1, 'two', 3, 16, 'orange :)' },
          mixed = {
            'a',
            6,
            type = 'babinga',
            foo = function(txt)
              return ('foogy' .. txt) or 'foogy'
            end,
            bar = 'bar',
          },
          nest = {
            15,
            cat = 'nested',
            { 3, lvl = 2, val = 100, 'first one', { 'yes', ['a-b'] = false, cat = 'thingy', lvl = 3 } },
            cfg = { -1, 120, val = 4.169, lvl = 2, { cat = { 'list', 'vals', lvl = 3 } } },
          },
        },
      }, --context table luapad buffer is evaluated with. these will be globals within luapad
      -- ───────────────────────────────────────────────────────────────────
      split_orientation = 'vertical', --|'horizontal'
    },
  },
}
