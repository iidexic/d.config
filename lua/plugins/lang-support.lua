return {
  -- ────────────────────────────────[ Other ]──────────────────────────────
  -- nushell. This is the only one, its for null-ls though. Try anyway?
  { 'LhKipp/nvim-nu', enabled = false, build = ':TSInstall nu', opts = {} },
  -- ───────────────────────────────[ Python ]──────────────────────────────
  { -- open/convert jupyter notebooks to .py files with hydrogen (or other) style.
    'GCBallesteros/jupytext.nvim',
    enabled = false,
    -- Depending on your nvim distro or config you may need to make the loading not lazy
    -- lazy=false,
  },
  { -- helper for automated imports, mainly for pyright lsp
    'stevanmilic/nvim-lspimport',
    enabled = false,
    -- suggests a mapping:
    -- vim.keymap.set("n", "<leader>a", require("lspimport").import, { noremap = true })
    -- find a way to make this an autocommand if end up using
  },
  {
    'benlubas/molten-nvim',
    ---opts = {},
    enabled = false,
  },
  { -- runs python code. I am guessing it prefers hydrogen format
    -- the readme says may only be usable if using vimscript config files.
    'smzm/hydrovim',
    dependencies = { 'MunifTanjim/nui.nvim' },
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
      'rcarriga/nvim-dap-ui',
      'theHamsta/nvim-dap-virtual-text',
    },
    config = function()
      require('go').setup {
        --lsp_cfg = true,
        build_tags = '-tags=mage',
      }
    end,
    event = { 'CmdlineEnter' },
    ft = { 'go', 'gomod' },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
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
    cond = true,
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
