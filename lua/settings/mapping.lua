-- mapping helper functions
vim.keymap.set('i', '<C-l>', '<esc><l><a>', { desc = 'edit shift right' })
local function cmd(s)
  return '<cmd>' .. s .. '<CR>'
end
local function dsc(s)
  return { desc = s }
end
local function ld(s)
  return '<leader>' .. s
end

local function toggletermFlip() -- assigned to alt-backslash in map.assign
  local term = require('toggleterm.terminal').get(1)
  if term and term.direction == 'horizontal' then
    term.change_direction(term, 'vertical')
  elseif term then
    term.change_direction(term, 'horizontal')
  end
end

---@ map_toggleterm sets mappings to be used in terminal
local function map_toggleterm()
  function _G.ttmap()
    local opts = { buffer = 0 }
    vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
    --vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts) I think this making lazygit shit work bad
    vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts) --{ '<Esc><Esc>', '<C-\\><C-n>' }--wtf is this
    vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
    vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
    vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
    vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
    -- works only when term not selected/not open?
    --opts.desc = 'ToggleTermFlip' --vim.keymap.set('t', '<M-\\>', toggletermFlip, opts)
  end
  -- if you only want these mappings for toggle term use term://*toggleterm#* instead
  vim.cmd 'autocmd! TermOpen term://* lua ttmap()'
end

local pluginmappings = {}

--- Which-key add all tables of mappings in mtable
local function wkMapFromTable(mtable)
  local wk = require 'which-key'
  for _, mappings in pairs(mtable) do
    wk.add(mappings)
  end
end
local function tabpage_next()
  local nextpg = vim.api.nvim_get_current_tabpage() + 1
  if vim.api.nvim_tabpage_is_valid(nextpg) then
    vim.api.nvim_set_current_tabpage(nextpg)
  end
end
local function tabpage_prev()
  local prevpg = vim.api.nvim_get_current_tabpage() - 1
  if vim.api.nvim_tabpage_is_valid(prevpg) then
    vim.api.nvim_set_current_tabpage(prevpg)
  end
end
---@param n number tabpage number to go to
local function tabpage_goto(n)
  if vim.api.nvim_tabpage_is_valid(n) then
    vim.api.nvim_set_current_tabpage(n)
  end
end
local maptables = {
  -- Trying whichkey-style above
  vismode = {
    --{ 'v', '<C-l>', vim.cmd },
  },
  --NOTE: Thinking all mappings should be after lazy init?
  --      I don't think descriptions here go to which-key.
  --      Which-key description for go mappings is just using command name
  assigns = {
    -- trouble don't work good
    { '<leader>q', vim.diagnostic.setloclist, dsc 'Quickfix list' },
    { '<Esc>', '<cmd>nohlsearch<CR>' },
    { '<C-h>', '<C-w><C-h>', dsc 'Move focus to the left window' },
    { '<C-k>', '<C-w><C-k>', dsc 'Move focus to the upper window' },
    { '<C-l>', '<C-w><C-l>', dsc 'Move focus to the right window' },
    { '<C-j>', '<C-w><C-j>', dsc 'Move focus to the lower window' },
    { '|', cmd 'lua MiniFiles.open()', dsc 'MiniFiles open' },
    { '<M-\\>', toggletermFlip, dsc 'ToggleTerm Flip' },
    { '<M-h>', tabpage_prev, dsc 'previous tabpage' },
    { '<M-l>', tabpage_next, dsc 'next tabpage' },
    -- -- this is going to be set in autocommands,
    --[[ { 'gh', function() vim.lsp.buf.signature_help { max_width = 86, max_height = 30 } end, dsc 'show signature help. (hover="KK")', }, ]]
  },

  go = { -- changed first key after leader to 'l'
    { '<leader>lr', cmd 'GoRun', dsc 'Go Run' },
    { '<leader>ld', cmd 'GoDoc', dsc 'GoDoc lookup' },
    { '<leader>lD', cmd 'GoSearch', dsc 'GoSearch (godoc.nvim)' },
    { '<leader>la', cmd 'GoAlt', dsc 'Toggle to test file' },
    { '<leader>lf', cmd 'GoRun -F', dsc 'Go Run Floating window' },
    { '<leader>lb', cmd 'GoBuild', dsc 'Go Build to cwd' },
    { '<leader>lt', cmd 'GoTest -n', dsc 'Go Test selected' },
    { '<leader>lm', cmd 'GoModTidy', dsc 'Go Mod Tidy' },
    { '<leader>ln', cmd 'GoRename', dsc 'Go Rename symbol' },
    { '<leader>lI', cmd 'GoImpl', dsc 'GoImpl' },
  },
  lsp_learning = {
    --{ '<A-l>h', vim.lsp.buf.hover(), dsc 'show hover info' }, this is already on 'K'
  },
}
local Map = {
  assign = function()
    vim.keymap.set('v', '<A-r>', ':lua<CR>', { desc = 'run selected lua code' })
    map_toggleterm()

    --# Apply Mappings
    wkMapFromTable(maptables)
    wkMapFromTable(pluginmappings)
  end,
}
function Map.configReloads()
  local cmap = {
    { '<leader>Ra', require('settings.autocommands').post_autocmd, desc = '[R]eload [a]utocommands' },
    {
      '<leader>Rm',
      function()
        Map.assign()
        Map.plugins()
      end,
      desc = '[R]erun [m]appings file',
    },
  }
  return cmap
end
-- Map.plugins performs all post-lazy mappings
-- in the future it will be all mappings
-- need to change the name of it
function Map.plugins()
  Map.wk = require 'which-key' -- does this cause use of extra mem throughout nvim running or does it just point?
  local pr = require 'persistence'
  Map.wk.add {
    mode = 'n',
    {
      { ld 'ps', pr.load, desc = 'Load cwd session' },
      { ld 'pS', pr.select, desc = 'Select session' },
      {
        ld 'pl',
        function()
          pr.load { last = true }
        end,
        desc = 'Load last session',
      },
      { ld 'pd', pr.stop, desc = 'Disable session save' },
    },
  }
  local mappingFunctions = { Map.gitplugins, Map.other_plugins, Map.leap, Map.commentbox, Map.configReloads, Map.lsp }
  for _, mfn in ipairs(mappingFunctions) do
    Map.wk.add(mfn())
  end
end

function Map.lsp()
  local lspsaga = require 'lspsaga'
  local m = {
    { ld 'o', cmd 'Lspsaga outline', desc = '[o]utline Lspsaga' },
    { ld 'd', cmd 'Lspsaga diagnostic', desc = '[d]iagnostic Lspsaga' },
  }
  return m
end
function Map.vim()
  local m = {
    { 'gl', vim.lsp.buf.incoming_calls(), desc = 'show incoming calls to symbol under cursor' },
    { '<leader>q', require('trouble').open { mode = '' } },
  }
  return m
end

function Map.gitplugins()
  local tinygit = require 'tinygit'
  local neogit = require 'neogit'
  return {
    { '<leader>ga', tinygit.interactiveStaging, desc = 'git add' },
    { '<leader>gc', tinygit.smartCommit, desc = 'git commit' },
    { '<leader>gp', tinygit.push, desc = 'git push' },
    { '<leader>gn', neogit.open, desc = 'Neogit' },
    {
      '<leader>gm',
      function()
        neogit.open { kind = 'vsplit' }
      end,
      desc = 'Neogit in vsplit',
    },
    { ld 'gf', require('diffview').open {} },
  }
end

function Map.commentbox()
  --write bool choice tbl
  local CB = { b = 1, l = 1 }
  local fcbs = function(write, choice)
    if write then
      --vim.tbl.extend or something
    end
  end
  local km = {
    --b 1,2,3 = rounded, square, heavy, 4 dashed, 7 double
    --b 12 = quote 13 = double lnquote, 18 vert enclose (L/R), 20 horiz enclose (top/btm)
    --l (2,3) rounded dwn/up, (4,5) square dwn/up,  (6,7,8) enclosed {[,(,<)]},
    --l 9 heavy ln , 12 weighted, 13 double
    --box: b-1, s-2 (square), q-12/13, ev-18,eh-20, h-9
    --[[ Ideally: set-up to toggle options (like box style # and alignment), but to also stay in a custom mode with custom keymap until command done ]]

    { 'gCb', cmd('CBlcbox ' .. 1) },
    { 'gCl', cmd 'CBllline ' .. 1 },
    { 'gCs', cmd 'CBlcbox ' .. 2 },
    { 'gCq', cmd('CBlcline ' .. 2) },
  }
  return km
end
function Map.other_plugins()
  local precog = require 'precognition'
  --local neoclip = require('neo')
  local aerial = require 'aerial'
  local m = {
    -- Precognition
    { ld 'up', precog.toggle, desc = '[U]til: [p]recognition toggle' },
    -- Aerial
    { ld 'ua', aerial.open, desc = '[U]til: [a]erial' },
    -- Ccc
    { ld 'uc', cmd 'CccPicker', desc = '[U]til: [c]cc colorpicker' },
    -- Trevj. this uh splits lists etc into lines? That's what it seems like at least
    { '<A-j>', require('trevj').format_at_cursor, desc = 'breakout list to lines' },
    -- Render-Markdown
    { 'gm', cmd 'RenderMarkdown toggle', desc = 'Render Markdown' },
    -- inc-rename
    -- NOTE: provided function does not work.
    -- { 'gR', function() return ':IncRename ' .. vim.fn.expand '<cword>' end, desc = 'iRename symbol', },
    { 'gR', ':IncRename ', desc = 'Start IncRename' },
  }
  return m
end
function Map.leap()
  return {
    { 'S', '<Plug>(leap-anywhere)', desc = 'leap anywhere' },
    { '<C-s>', '<Plug>(leap)', desc = 'leap', mode = { 'i', 'n' } },
  }
end

-- ╭──────────────╮
-- │ not used yet │
-- ╰──────────────╯
function Map.hover()
  -- Setup keymaps
  vim.keymap.set('n', 'K', require('hover').hover, { desc = 'hover.nvim' }) -- replace default hover
  vim.keymap.set('n', 'gK', require('hover').hover_select, { desc = 'hover.nvim (select)' }) -- new?
  vim.keymap.set('n', '<C-p>', function()
    require('hover').hover_switch 'previous'
  end, { desc = 'hover.nvim (previous source)' })
  vim.keymap.set('n', '<C-n>', function()
    require('hover').hover_switch 'next'
  end, { desc = 'hover.nvim (next source)' })

  -- Mouse support - eh why not
  vim.keymap.set('n', '<MouseMove>', require('hover').hover_mouse, { desc = 'hover.nvim (mouse)' })
  vim.o.mousemoveevent = true
end
--[[ function Map.obs()
  -- n key currently not occupied, so these are fine.
  local mappings = {
    { '<leader>nn', '<cmd>ObsNvimFollowLink<cr>', desc = 'Obs Follow Link' },
    { '<leader>nr', '<cmd>ObsNvimRandomNote<cr>', desc = 'Obs open [r]andom Note' },
    { '<leader>nN', '<cmd>ObsNvimNewNote<cr>', desc = 'Obs [N]ew note' },
    { '<leader>ny', '<cmd>ObsNvimCopyObsidianLinkToNote<cr>', desc = 'Obs [y]ank link to obsidian note' },
    { '<leader>no', '<cmd>ObsNvimOpenInObsidian<cr>', desc = 'Obs [o]pen in Obsidian' },
    --{ '<leader>nd', '<cmd>ObsNvimDailyNote<cr>' ,desc = 'Obs [D]aily Note'},
    { '<leader>nw', '<cmd>ObsNvimWeeklyNote<cr>', desc = 'Obs [w]eekly Note' },
    { '<leader>nrn', '<cmd>ObsNvimRename<cr>', desc = 'Obs [r]e[n]ame' },
    { '<leader>nT', '<cmd>ObsNvimTemplate<cr>', desc = 'Obs [T]emplate' },
    { '<leader>nM', '<cmd>ObsNvimMove<cr>', desc = 'Obs [M]ove' },
    { '<leader>nb', '<cmd>ObsNvimBacklinks<cr>', desc = 'Obs [b]acklinks' },
    { '<leader>nfj', '<cmd>ObsNvimFindInJournal<cr>', desc = 'Obs [f]ind in [j]ournal' },
    { '<leader>nff', '<cmd>ObsNvimFindNote<cr>', desc = 'Obs [f]ind [n]ote' },
    { '<leader>nfg', '<cmd>ObsNvimFindInNotes<cr>', desc = 'Obs [f]ind in notes' },
  }
  Map.wk.add(mappings)
end
 ]]
return Map
