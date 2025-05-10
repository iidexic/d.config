return {
  --{ 'ray-x/navigator.lua', dependencies = { 'neovim/nvim-lspconfig', { 'ray-x/guihua.lua' } } },
  ---* Zig *---
  { 'ziglang/zig.vim' },
  --==| GOLANG |==--
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
      require('go').setup()
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
    enabled = false,
    ft = 'go',
    cmd = { 'GosignsEnable', 'GosignsDisable', 'GosignsToggle' },
    opts = {}, -- for default options. Refer to the configuration section for custom setup.
  },
  --[[
  { -- run impl to generate interface method stubs, uses telescope
    -- <leader>gi has been assigned to run impl for now
    'edolphin-ydf/goimpl.nvim',
    requires = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-lua/popup.nvim' },
      { 'nvim-telescope/telescope.nvim' },
      { 'nvim-treesitter/nvim-treesitter' },
    },
    -- NOTE: if having issues re-include this config function and remove from telescope side
    config = true, --function() require('telescope').load_extension 'goimpl' end,
  },
  --]]
  {
    'crusj/structrue-go.nvim',
    branch = 'main',
    --requires gotags: `go get -u github.com/jstemmer/gotags`
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
  --==| GOLANG |==--
  { -- lua scratchpad, interactive repl type deal
    'rafcamlet/nvim-luapad',
    requires = 'antoinemadec/FixCursorHold.nvim',
  },
}
