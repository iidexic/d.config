return {
  -- ────────────────────────────────[ Other ]──────────────────────────────
  -- nushell. This is the only one, its for null-ls though. Try anyway?
  { 'LhKipp/nvim-nu', enabled = false, build = ':TSInstall nu', opts = {} },
  -- ───────────────────────────────[ Python ]──────────────────────────────
  { -- open/convert jupyter notebooks to .py files with hydrogen (or other) style.
    'GCBallesteros/jupytext.nvim',
    config = true,
    -- Depending on your nvim distro or config you may need to make the loading not lazy
    -- lazy=false,
  },
  { -- helper for automated imports, mainly for pyright lsp
    'stevanmilic/nvim-lspimport',
    cond = false,
    -- suggests a mapping:
    -- vim.keymap.set("n", "<leader>a", require("lspimport").import, { noremap = true })
    -- find a way to make this an autocommand if end up using
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
      --'stevearc/dressing.nvim', -- added to vis on cond=false
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
    cond = false,
  },
  -- ────────────────────────────────[ Zig ]────────────────────────────────
  { 'ziglang/zig.vim' },

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
      require('go').setup {}
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
    enabled = true,
    ft = 'go',
    cmd = { 'GosignsEnable', 'GosignsDisable', 'GosignsToggle' },
    opts = {}, -- for default options. Refer to the configuration section for custom setup.
  },
  {
    'fredrikaverpil/godoc.nvim',
    version = '*',
    dependencies = {
      { 'nvim-telescope/telescope.nvim' }, -- optional
      {
        'nvim-treesitter/nvim-treesitter',
        opts = {
          ensure_installed = { 'go' },
        },
      },
    },
    build = 'go install github.com/lotusirous/gostdsym/stdsym@latest', -- optional
    cmd = { 'GoSearch' }, -- optional
    opts = {
      adapters = {
        -- for details, see lua/godoc/adapters/go.lua
        {
          name = 'go',
          opts = {
            command = 'GoSearch', -- the vim command to invoke Go documentation
            get_syntax_info = function()
              return {
                filetype = 'godoc', -- filetype for the buffer
                language = 'go', -- tree-sitter parser, for syntax highlighting
              }
            end,
          },
        },
      },
      window = {
        type = 'split', -- split | vsplit
      },
      picker = {
        type = 'telescope', -- native (vim.ui.select) | telescope | snacks | mini | fzf_lua
        telescope = {},
      },
    }, -- see further down below for configuration
  }, -- godoc.nvim removed for now
  -- ────────────────────────────────[ Lua ]────────────────────────────────
  --{ 'ray-x/navigator.lua', dependencies = { 'neovim/nvim-lspconfig', { 'ray-x/guihua.lua' } } },
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
        t = { --#FOLD---------------
          dict = { one = 1, two = 2, three = '3', five = 'nan', four = nil },
          list = { 1, 'two', 3, 16, 'orange :)' },
          lnums = { 1513, 205, 9647, 135.0, 249.58, -369.4, 1035.135 },
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
            lvl = 1,
            cat = 'nested',
            val = 0,
            { 3, lvl = 2, val = 100, 'first one', { 'yes', ['a-b'] = false, cat = 'thingy', lvl = 3 } },
            cfg = { -1, 120, val = 4.169, lvl = 2 },
            { cat = { 'list', 'vals', lvl = 3 } },
          },
          nested = {
            tb1 = { win = true, lose = 'that sucks', 14, pct = 0.465479 },
            tb2 = { 4, 135, 93.845, src = 'nvim-luapad' },
            { 200, 201, 202, 203, 204 },
            'stringy',
            { 'table', 'of', 'strings' },
            tbl_of_strings = { stringOne = 'one', stringTwo = '2' },
          },
        },
        -- I think this was just a nonsense function to check shit
        categorizee = function(tbl, d, l, sum) --#FOLD----------------
          for k, v in pairs(tbl) do
            if type(k) == 'string' then
              d[k] = v
              if type(v) == 'number' then
              elseif type(v) == 'string' then
                d.str = d.str .. v
              end
            elseif type(k) == 'number' then
              table.insert(l, v)
              if sum[k] then
                sum[k] = sum[k] + v
              else
                sum[k] = v
              end
            end
          end
        end,
        fnunctoin = function(n1, n2, tbl)
          table.insert(tbl, { n1, n2 })
          return (n1 * n2)
        end,
        -- TODO: add Plugin requires for luapad
      }, --context table luapad buffer is evaluated with. these will be globals within luapad
      -- ───────────────────────────────────────────────────────────────────
      split_orientation = 'vertical', --|'horizontal'
    },
  },
}
