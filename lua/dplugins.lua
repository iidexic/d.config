local D = { plugins = {} }
D.dplugins = {
  { --> plugins_tools
    'willothy/flatten.nvim',
    config = true, -- or pass configuration with opts = {  }
    lazy = false,
    priority = 1001, -- Ensure that it runs first to minimize delay when opening file from terminal
  },
  { 'ray-x/navigator.lua', dependencies = { 'neovim/nvim-lspconfig', { 'ray-x/guihua.lua' } } },
  { --> codeplugins
    'ray-x/go.nvim',
    dependencies = { -- optional packages
      'ray-x/guihua.lua',
      'neovim/nvim-lspconfig',
      'nvim-treesitter/nvim-treesitter',
      'rcarriga/nvim-dap-ui',
    },
    opts = { remap_commands = { GoDoc = false } },
    config = function()
      require('go').setup()
    end,
    event = { 'CmdlineEnter' },
    ft = { 'go', 'gomod' },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },
  { --> codeplugins
    'maxandron/goplements.nvim',
    ft = 'go',
    opts = {},
  },
  { -->plugins_tools
    'LintaoAmons/scratch.nvim',
    event = 'VeryLazy',
  },
  { -->codeplugins
    -- run impl to generate interface method stubs, uses telescope
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
  { -->codeplugins
    'crusj/structrue-go.nvim',
    branch = 'main',
    --requires gotags: `go get -u github.com/jstemmer/gotags`
    opts = {
      keymap = {
        toggle = '<leader>gs', -- toggle structure-go window
        show_others_method_toggle = 'H', -- show or hidden the methods of struct whose not in current file
        symbol_jump = '<CR>', -- jump to then symbol file under cursor
        center_symbol = '\\f', -- Center the highlighted symbol
        fold_toggle = '\\z',
        refresh = 'R', -- refresh symbols
        preview_open = 'P', -- preview  symbol context open
        preview_close = '\\p', -- preview  symbol context close
      },
    },
  },
  --[[ Disabled. godoc.nvim is not really working, neorg is kinda messy
  { -- Search godocs using telescope, also doesn't really work
    --NOTE: `GoDoc` is a ray-x/go.nvim command. Changing here doesn't do much
    'fredrikaverpil/godoc.nvim',
    dependencies = {
      { 'nvim-telescope/telescope.nvim' },
      { 'nvim-treesitter/nvim-treesitter', opts = { ensure_installed = { 'go' } } },
    },
    build = 'go install github.com/lotusirous/gostdsym/stdsym@latest', -- optional
    keys = { '<leader>gd', '<cmd>GoDoc<cr>', desc = 'Search Go Documentation' },
  },
  
  {
    'nvim-neorg/neorg',
    lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
    version = '*', -- Pin Neorg to the latest stable release
    config = true,
  },
  --]]
  { --> conditionals
    'willothy/wezterm.nvim',
    config = true,
    enabled = false,
    opts = {
      create_commands = true,
    },
    lazy = true,
  },
  { --> plugins_git
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim', -- required
      'sindrets/diffview.nvim', -- optional - Diff integration
      'nvim-telescope/telescope.nvim', -- optional
    },
  },
  { --> plugins_tools
    'akinsho/toggleterm.nvim',
    version = '*',
    opts = {
      open_mapping = [[<C-\>]],
      persist_size = false,
    },
    config = true,
    lazy = false,
    keys = { { '<leader>at', '<cmd>ToggleTerm<cr>', desc = '[A]pp: [t]erminal' } },
  },
  { --> conditionals.
    --[[ Pineapple Disabled
    Pineapple has a problem where it causes big stinky errors when disabled
    This stems from the file placed in after/plugins folder.
    I am wondering if we can get away with not even having this.
    All it does is trigger using a specific colorscheme, but I am controlling that manually regardless

    That does give me the thought: I can also put shit in there that is my own
    --]]
    'CWood-sdf/pineapple',
    enabled = false,
    dependencies = require 'theme.pineapple',
    --! PINEAPPLE DISABLED. uncomment opts when it is re-enabled
    --opts = { installedRegistry = 'theme.pineapple', colorschemeFile = 'after/plugin/themedata.lua' },
    cmd = 'Pineapple',
    lazy = true,
    keys = { { '<leader>ap', '<cmd>Pineapple<cr>', desc = '[A]pp: [P]ineapple' } },
  },
  --[[ removing unneeded:
1. neaterm - dont want fzf have tellyscope
2. hydra - cool idea, don't need it for now
  { 'Dan7h3x/neaterm.nvim', branch = 'stable', event = 'VeryLazy', opts = { },
    dependencies = { 'nvim-lua/plenary.nvim', 'ibhagwan/fzf-lua', }, },
  { 'anuvyklack/hydra.nvim', },
--]]
}
function D.join(tbl1, tbl2)
  for _, val in ipairs(tbl2) do
    table.insert(tbl1, val)
  end
  return tbl1
end

function D.imergetables(tables)
  local result = {}
  for _, tbl in ipairs(tables) do
    for _, val in ipairs(tbl) do
      table.insert(result, val)
    end
  end
  return result
end

function D.add_module_plugins(modulestring)
  local plugs = require(modulestring)
  D.join(D.plugins, plugs)
end
function D.add_plugin_link(plugin_link)
  table.insert(D.plugins, { plugin_link })
end
return D

----# Other themes:
--'olivercederborg/poimandres' - it's nice, minimal but greenish color pops, minty, wezterm version
--'ramojus/mellifluous' - multiple colorsets, one I see is kanagawa-ish
--** 'cryptomilk/nightcity' - afterlife variant looks great, halloweeney
--'ribru17/bamboo' - looks like kanagawa dragon
--'sainnhe/edge', one/atom-esque, three variants
--'2nthony/vitesse', it's vitesse
--'FrenzyExists/aquarium-vim', it's good! somewhere between muted tokyo and dracula
--'yonlu/omni', purple bg with dracula-ish colors but with a bit more pop and slightly warmer
---- These Ray-x ones seem very customizable. Cool but maybe later
--'ray-x/aurora', seems excessive I'll be honest. a lot of color.
--'ray-x/starry', a pack of themes. Includes purpley ones, draculas, monokai,mariana, emerald, solar

--= If want to conditionally load for neovide: =--
--[[
local D = {}
function D.plugins()
local plugins_neovide = {}
local not_neovide = { { 'willothy/wezterm.nvim', config = true, opts = { create_commands = true, }, } }
    if vim.g.neovide then

    else

    end
end
--]]
