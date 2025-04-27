local D = { plugins = {} }
D.dplugins = {
  {
    'willothy/flatten.nvim',
    config = true, -- or pass configuration with opts = {  }
    lazy = false,
    priority = 1001, -- Ensure that it runs first to minimize delay when opening file from terminal
  },
  {
    'ray-x/go.nvim',
    dependencies = { -- optional packages
      'ray-x/guihua.lua',
      'neovim/nvim-lspconfig',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('go').setup()
    end,
    event = { 'CmdlineEnter' },
    ft = { 'go', 'gomod' },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },
  {
    'willothy/wezterm.nvim',
    config = true,
    opts = {
      create_commands = true,
    },
    lazy = true,
  },
  --{ 'lmantw/themify.nvim', lazy = false, priority = 999, config = {}, },
  {
    'CWood-sdf/pineapple',
    dependencies = require 'theme.pineapple',
    opts = {
      installedRegistry = 'theme.pineapple',
      colorschemeFile = 'after/plugin/themedata.lua',
    },
    cmd = 'Pineapple',
    lazy = true,
    keys = { { '<leader>ap', '<cmd>Pineapple<cr>', desc = '[A]pp: [P]ineapple' } },
  },
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    opts = {
      open_mapping = [[<C-\>]],
    },
    config = true,
    lazy = true,
    --keys = { { '<leader>at', '<cmd>ToggleTerm<cr>', desc = '[A]pp: [t]erminal' }, },
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
