--#Utility Functions
local cmd = function(cstr)
  return '<cmd>' .. cstr .. '<cr>'
end
local ldr = function(keys)
  return '<leader' .. keys
end
--#Function Tables
local fntblVim = {
  tabpage_next = function()
    local nextpg = vim.api.nvim_get_current_tabpage() + 1
    if vim.api.nvim_tabpage_is_valid(nextpg) then
      vim.api.nvim_set_current_tabpage(nextpg)
    end
  end,
  tabpage_prev = function()
    local prevpg = vim.api.nvim_get_current_tabpage() - 1
    if vim.api.nvim_tabpage_is_valid(prevpg) then
      vim.api.nvim_set_current_tabpage(prevpg)
    end
  end,
  ---@param n number tabpage number to go to
  ---@problem cannot call in keybind proper
  tabpage_goto = function(n)
    if vim.api.nvim_tabpage_is_valid(n) then
      vim.api.nvim_set_current_tabpage(n)
    end
  end,
}
local fntblPlugins = {
  --  ╭─────────────────────────────────────────────── ToggleTerm Binds ─╮
  map_toggleterm = function()
    function _G.ttmap()
      local opts = { buffer = 0 }
      vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
      vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts) --{ '<Esc><Esc>', '<C-\\><C-n>' }--wtf is this
      vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
      vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
      vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
      vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
      --vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts) I think this making lazygit shit work bad
    end
    -- if you only want these mappings for toggle term use term://*toggleterm#* instead
    vim.cmd 'autocmd! TermOpen term://* lua ttmap()'
    -- ──────────────────────────────────────────────────────────────────────
  end,
  toggletermFlip = function()
    local term = require('toggleterm.terminal').get(1)
    if term and term.direction == 'horizontal' then
      term.change_direction(term, 'vertical')
    elseif term then
      term.change_direction(term, 'horizontal')
    end
  end,
  -- ╰────────────────────────────────────────────────────────────────────╯
  persistence_loadlast = function()
    require('persistence').load { last = true }
  end,
}
-- ┌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌┐
-- ╎                     Keybind Tables                      ╎
-- └╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌┘
local binds = {}
binds.preLazy = {
  builtins = {
    { '<leader>q', vim.diagnostic.setloclist },
    { '<Esc>', '<cmd>nohlsearch<CR>' },
    { '<C-h>', '<C-w><C-h>', desc = 'Move focus to the left window' },
    { '<C-k>', '<C-w><C-k>', desc = 'Move focus to the upper window' },
    { '<C-l>', '<C-w><C-l>', desc = 'Move focus to the right window' },
    { '<C-j>', '<C-w><C-j>', desc = 'Move focus to the lower window' },
    { '|', cmd 'lua MiniFiles.open()', desc = 'MiniFiles open' },
    { '<M-h>', fntblVim.tabpage_prev, desc = 'previous tabpage' },
    { '<M-l>', fntblVim.tabpage_next, desc = 'next tabpage' },
  },
}
binds.plugins = {
  persistence = { '<leader>', { ldr 'Ps', run = 'load', desc = 'Load cwd session' }, { ldr 'PS', run = 'select', desc = 'Select session' } },
  tinygit = {
    '<leader>',
    desc = 'git',
    { 'ga', run = 'interactiveStaging', desc = 'add' },
    { 'gc', run = 'smartCommit', desc = 'commit' },
    { 'gp', run = 'push', desc = 'push' },
  },
  toggleterm = {
    { '<M-\\>', fntblPlugins.toggletermFlip, desc = 'ToggleTerm Flip' }, -- this is buggy
  },
}
-- All comment-box

--- keeps a number within bounds defined by limit. any number over
---@alias boundsdict {min:number,max:number} dict form of bounds
---@param newval number # calculated number to check for saturation
---@param bounds number[]|boundsdict # table with lower/upper bounds, either as a list number[minval,maxval] or as {min=_,max=_}
---@return number # the saturated value: will be newval or one of the limit values
local saturating = function(newval, bounds)
  ---@type number
  local min, max
  min = bounds[1] or bounds.min
  max = bounds[2] or bounds.max
  if not min and not max then
    return newval
  end
  if min and newval < min then
    return min
  end
  if max and newval > max then
    return max
  end
  return newval
end

---@type number[]
local boxbounds = { 1, 22 }
local linebounds = { 1, 17 }

local cbselect = { b = 1, l = 1 }

---update the desired comment-box style for box or line
---@param box? number # new box number/box increment
---@param line? number # new line number/line increment
---@param increment? boolean # if increment, value will be summed with current select value.
local function set_cb(box, line, increment)
  if increment then
    if box then
      cbselect.b = saturating(cbselect.b + box, boxbounds)
    end
    if line then
      cbselect.l = saturating(cbselect.l + line, linebounds)
    end
  else
    if box then
      cbselect.b = saturating(box, boxbounds)
    end
    if line then
      cbselect.l = saturating(line, linebounds)
    end
  end
end
binds.commentbox = {
  plugin = 'comment-box',
  args = cbselect,
  {
    mode = 'i',
    prefix = '<C-b>',

    { 'b', run = 'lcbox' },
    { 'l', run = 'lcline' },
  },
  {
    mode = '',
    'gC',
    args = cbselect,
    { 'b', run = 'lcbox' },
    { 'l', run = 'lcline' },
  },
}

--          ╒═════════════════════════════════════════════════════════╕
--          │                     MAPPER FOR DMAP                     │
--          ╘═════════════════════════════════════════════════════════╛
local mapper = {}
local option_names = { 'mode', 'disable_join', 'run', 'plugin', 'args', 'rawdog', 'prefix', 'modifier', 'apply_modifier' }
local pmap = {
  mode = 'n',
  rawdog = true,
  disable_join = nil,
  run = nil,
  plugin = nil,
  args = nil,
  prefix = nil,
  modifier = nil,
  apply_modifier = nil,
}
local depthCursor = { 1 }
local depthOptions = {}

---getopts will return only map/dmap options at that particular depth, not including keybinds
---@param t table @full map
---@return table
local function getopts(t)
  local sopts = {}
  for k, n in pairs(t) do
    if type(k) == 'string' then
      sopts[k] = n
    end
  end
  return sopts
end

local function hasoptions(t) end

---@ recursively parses dmap and builds final map to apply
local function build_map(t, depth) end
---@param mappings table @dmap-formatted map table

function mapper.dmap(mappings)
  if hasoptions() then
    local effmap = vim.tbl_deep_extend('force', pmap, getopts(mappings))
    if mappings[1] and mappings[2] and mappings[2] ~= '' then
    end
  end
end
--[[
-- ═══════════════════════════ The Dmap format ═══════════════════════════
╭─────────────────────────────────────────────────────────────────────────────╮

 ───[ Functionality ]──────────────────────────────────────────────────
  Dmap is a tool to make easier/more organized mappings
  It consists of:
    • a specification that details how to build mapping tables
    • one function that will take the Dmap tables and make all resulting
      mappings as well as populate which-key
 ───[ Mapping Spec: ]──────────────────────────────────────────────────
  The following rules define the mapping spec:
  1. binds have number/int keys, options have string keys
    number keys: map[1] = (lhs), map[2] = fn/cmd, map[3] = desc
  1a. if list val is a table (ie. type(map[n]) == 'table'), it will be treated as its own table

  2. any options set in a table will apply to all mappings
    at an equal or lower depth in that table

  3. bind info (map[1]/lhs and map[3]/desc) will be depth-joined by default:
    mappings are joined/appended from highest to lowest depth.
    example: m = {'<leader>',{'a',afunc, 'action',{'s',sfunc, ': search'}}}
    creates the mappings: {'<leader>a', afunc, desc = 'action'}
                          {'<leader>as', sfunc, desc = 'action: search'}
    (NOTE: to add desc without mapping a command, either use desc= or set the cmd/rhs to '')

  4. deeper-set options will override values set at higher levels

  5. binding plugin functions  can be done in multiple ways:
    • using `run = 'function_name'` in place of rhs.
      you can set the plugin with `plugin = 'plugin_name'`,
      or the key that the mapping table is assigned to will be used
      ─── binding example: ───────────────
        m = {'<leader>x', run = 'show', plugin = 'which-key',mode='n'}
           OR
        m = {mode='n'}
        m['which-key'] = {{'<leader>x', run='show'}}
      will both result in the mapping:
        {'<leader>x', require('which-key').show}
      ────────────────────────────────────
  6. Additional options added: --> format = `option_key` (type)[default]: description
    • `plugin` (string): defines plugin to require if `run` option set and no other rhs
    • `run` (string): defines function name to be called for given plugin
    • `args` (any | table): argument to pass to run function
        if args is given, function call will be wrapped so arg can be applied
        if function requires multiple arguments, there are two options:
          -> {';x', run = 'foo', args = {'arg1', 'arg2', {'arg3','table'} }}
          *probably removing this. complicates shit too much ~> {';x', run = 'foo','', 'description', 'arg1','arg2','arg3'}
      ─── dmap function example: ─────────
      m = {plugin = 'nui', 'a', run = 'show', args={1,'a'}}
      resulting map: {'a', function() require(m.plugin)[m.run](args)}
      ────────────────────────────────────
    • `disable_join` (bool) - disables depth-join for lhs and desc
    • `rawdog` (bool)[=true]: if false, dmap will pcall the set function; if errors are received, the mapping is not made.
    • `prefix` (string) - defines key(s) to be added to each lhs in the table.
    • `modifier` (string) - defines modifier keys to attach lhs to
        -> alternatively: leave the angle brackets open at the end of the parent lhs
    • `apply_modifier` (string|number) - set priority for applying modifier.
        priority rule defines the key to be modified. if rule not met, modifies 'next-best' key
        options are:
        - 'default' or nil: first non-leader key (next-best = first key)
        - 'leader': leader key (next-best = first key)
        - 'first': first key
        - 'strict': first non-leader key, will not apply to leader
        - 'leader strict': will only apply to first leader key
        - 'second, third, fourth' or integer number: apply to nth key in motion (next best = previous key)
        - 'second strict' etc.: apply exclusively to nth key in motion

  {
  named_options='whatev',
  {keybind_info, override_option='whatev'}
  } 

   ───[ All Opts: ]───────────────────────────────────────────────────────
    - 1 (lhs)
    - 2 (rhs/command/function)
    - 3 (desc)
    - 4+: (multi-args)
    - desc
    - plugin
    - run
   ───────────────────────────────────────────────────────────────────────
╰─────────────────────────────────────────────────────────────────────────────╯
--]]
