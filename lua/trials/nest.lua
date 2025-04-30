--[[ 
Neovim utility plugin to define keymaps in cascading lists and trees
 -> Modular, maintainable pure Lua way to define keymaps
 -> Written in a single file of ~100 lines
 -> Supports mapping keys to Lua functions with expr support
 -> Allows grouping keymaps the way you think about them concisely
--]]
local nlink = { { 'LionC/nest.nvim' } }
local nest = require 'nest'
nest.applyKeymaps {
  -- I am too lazy to set this up for now
  --> check https://github.com/lionC/nest.nvim
}
return nlink
