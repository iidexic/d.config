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

---@enum toggleterm_mode
local ttmode = { h = 'horizontal', v = 'vertical', f = 'float', t = 'tab' }
local function toggleterm_mode(mode) -- assigned to alt-backslash in map.assign
  if mode then
    return function()
      local term = require('toggleterm.terminal').get(1)
      if term then
        term:change_direction(ttmode[mode])
      end
    end
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
    --opts.desc = 'ToggleTermFlip' vim.keymap.set('t', '<M-\\>', toggletermFlip, opts)
  end
  -- if you only want these mappings for toggle term only use term://*toggleterm#* instead
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
    { '<C-h>', '<C-w><C-h>', desc = 'Move focus to the left window' },
    { '<C-k>', '<C-w><C-k>', desc = 'Move focus to the upper window' },
    { '<C-l>', '<C-w><C-l>', desc = 'Move focus to the right window' },
    { '<C-j>', '<C-w><C-j>', desc = 'Move focus to the lower window' },
    { '|', cmd 'lua MiniFiles.open()', desc = 'MiniFiles open' },
    --hoping this will open wk
    { '<M-\\>', desc = 'ToggleTerm Mode' },
    { '<M-\\>h', toggleterm_mode 'h', desc = 'ToggleTerm Mode horizontal' },
    { '<M-\\>v', toggleterm_mode 'v', desc = 'ToggleTerm Mode vertical' },
    { '<M-\\>f', toggleterm_mode 'f', desc = 'ToggleTerm Mode float' },
    { '<M-\\>t', toggleterm_mode 't', desc = 'ToggleTerm Mode tab' },
    { '<M-h>', tabpage_prev, desc = 'previous tabpage' },
    { '<M-l>', tabpage_next, desc = 'next tabpage' },
    -- ── Custom Functions ────────────────────────────────────────────────
    {
      '<leader>vb',
      function()
        --local det = vim.fn.getbufinfo(vim.fn.bufnr())
        local bnum = vim.fn.bufnr()
        local bn = vim.fn.bufname(bnum)
        local btype = vim.fn.getbufvar(bnum, '&buftype')
        local b = 'BUFFER\nname: ' .. bn .. '\nnum: ' .. bnum .. '\ntype: ' .. btype
        vim.print(b)
      end,
      desc = 'Vim: print current buffer detail',
    },
    {
      '<C-w>f',
      function()
        vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.04
      end,
      desc = 'neovide scale ',
    },
    {
      '<C-w>F',
      function()
        vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.04
      end,
      desc = 'neovide scale ',
    },
  },

  --TODO: Future state have all lang-specific mappings on l and change them on project or file change
  go = { -- changed first key after leader to 'l'
    { '<leader>lr', cmd 'GoRun', desc = 'Go Run' },
    { '<leader>lr', cmd 'GoRun', desc = 'Go Run' },
    { '<leader>ld', cmd 'GoDoc', desc = 'GoDoc lookup' },
    { '<leader>lD', cmd 'GoSearch', desc = 'GoSearch (godoc.nvim)' },
    { '<leader>la', cmd 'GoAlt', desc = 'Toggle to test file' },
    { '<leader>lf', cmd 'GoRun -F', desc = 'Go Run Floating window' },
    { '<leader>lb', cmd 'GoBuild', desc = 'Go Build to cwd' },
    { '<leader>lt', cmd 'GoTest -n', desc = 'Go Test selected' },
    { '<leader>lm', cmd 'GoModTidy', desc = 'Go Mod Tidy' },
    { '<leader>ln', cmd 'GoRename', desc = 'Go Rename symbol' },
    { '<leader>lI', cmd 'GoImpl', desc = 'GoImpl' },
  },
  lsp_learning = {
    --{ '<A-l>h', vim.lsp.buf.hover(), dsc 'show hover info' }, this is already on 'K'
  },
}
local Map = {
  assign = function()
    -- moved next to wk
    --vim.keymap.set('v', '<A-r>', ':lua<CR>', { desc = 'run selected lua code' })
    map_toggleterm()

    --# Apply Mappings
    wkMapFromTable(maptables)
    wkMapFromTable(pluginmappings)
  end,
}

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
  Map.wk.add({
    { '<Leader>ui', '<cmd>IconPickerNormal<cr>', desc = 'Icon Picker 💪' },
  }, { silent = true })
  local mappingFunctions = {
    Map.gitplugins,
    Map.other_plugins,
    Map.leap,
    Map.commentbox,
    Map.lsp,
    Map.hover,
    Map.neovide,
    Map.vim,
  }
  for _, mfn in ipairs(mappingFunctions) do
    Map.wk.add(mfn())
  end
end

function Map.lsp()
  local lspsaga = require 'lspsaga'
  local m = {
    --{ '<leader>o', cmd 'Lspsaga outline', desc = '[o]utline Lspsaga' },
    { '<leader>d', cmd 'Lspsaga diagnostic', desc = '[d]iagnostic Lspsaga' },
  }
  return m
end
function Map.vim()
  local m = {
    { '<A-r>', ':lua<CR>', mode = 'v', desc = 'run selected lua code' },
    { 'gl', vim.lsp.buf.incoming_calls(), desc = 'show incoming calls to symbol under cursor' },
    -- removed. trouble quickfix is iffy
    --{ '<leader>q', require('trouble').open { mode = '' } },
  }
  return m
end

function Map.neovide()
  return {
    {
      '<C-w><leader>',
      function()
        vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
      end,
      desc = 'toggle neovide fullscreen',
    },
  }
end

function Map.gitplugins()
  local tinygit = require 'tinygit'
  local neogit = require 'neogit'
  return {
    { '<leader>ga', tinygit.interactiveStaging, desc = 'git add' },
    { '<leader>gc', tinygit.smartCommit, desc = 'git commit' },
    { '<leader>gp', tinygit.push, desc = 'git push' },
    {
      '<leader>gI',
      function()
        tinygit.issuesAndPrs { type = 'all', state = 'all' }
      end,
      desc = 'search Github issues + Pull Requests',
    },
    { '<leader>gh', tinygit.fileHistory, desc = 'search file history' },
    { '<leader>gn', neogit.open, desc = 'Neogit' },
    {
      '<leader>gm',
      function()
        neogit.open { kind = 'vsplit' }
      end,
      desc = 'Neogit in vsplit',
    },
    -- Need to add context or this will just open the full project diffview
    { ld 'gd', require('diffview').open, desc = 'open diffview' },
    -- Errors if not in diffview. Could be implementation problem
    -- try the plugin config keymap
    --[[ {
      '<esc><esc>',
      function()
        require('diffview.config').actions { 'close' }
      end,
      desc = 'close diffview',
    }, ]]
  }
end

function Map.commentbox()
  --write bool choice tbl
  --b 1,2,3 = rounded, square, heavy, 4 dashed, 7 double
  --b 12 = quote 13 = double lnquote, 18 vert enclose (L/R), 20 horiz enclose (top/btm)
  --l (2,3) rounded dwn/up, (4,5) square dwn/up,  (6,7,8) enclosed {[,(,<)]},
  --l 9 heavy ln , 12 weighted, 13 double
  --box: b-1, s-2 (square), q-12/13, ev-18,eh-20, h-9
  --[[ Ideally: set-up to toggle options (like box style # and alignment), but to also stay in a custom mode with custom keymap until command done ]]
  --NOTE: potential select type wip functions moved to new_mapping or newmap_functions
  local km = {

    --NOTE: cmd() not work with a join string?
    --NOTE: 'go' overwrites default bind of jumping to a specific byte number
    ------- if for some reason this becomes needed; switch back to gC, or use gp/gP(overwrites)
    { 'gob', cmd('CBlcbox ' .. 1) }, --left-justify text, center-justify box, round corner
    { 'goB', cmd 'CBlcbox 2' },
    { 'gol', cmd 'CBllline ' .. 1 }, --left-justify text, left-justify line, default line
    { 'gor', cmd('CBlcline ' .. 2) },
    { 'goR', cmd('CBlcline ' .. 3) },
    { 'gor', cmd('CBlcline ' .. 2) },
    { 'goR', cmd('CBlcline ' .. 3) },
    -- this is gCq
  }
  return km
end
function Map.other_plugins()
  local precog = require 'precognition'
  local grug = require 'grug-far'

  -- local dropbar_api = require 'dropbar.api'
  -- vim.keymap.set('n', '<Leader>;', dropbar_api.pick, { desc = 'Pick symbols in winbar' })
  -- vim.keymap.set('n', '[;', dropbar_api.goto_context_start, { desc = 'Go to start of current context' })
  -- vim.keymap.set('n', '];', dropbar_api.select_next_context, { desc = 'Select next context' })
  local m = {
    -- Bufferline:
    { 'g<CR>', '<cmd>BufferLinePick<cr>', desc = 'Switch Buffer (Line)' },
    { 'g<BS>', '<cmd>BufferLinePickClose<cr>', desc = 'Close Buffer (Line)' },
    -- Precognition
    { '<leader>up', precog.toggle, desc = '[U]til: [p]recognition toggle' },
    -- Aerial
    --{ ld 'ua', aerial.open, desc = '[U]til: [a]erial' },
    { '<leader>ua', '<cmd>AerialToggle!<CR>', desc = '[U]til: [a]erial' },
    -- Outline (in outline config in aerial.lua)
    -- Ccc
    { '<leader>uc', cmd 'CccPick', desc = '[U]til: [c]cc colorpicker' },
    { '<leader>uh', cmd 'CccHighlighterToggle', desc = '[U]til: ccc color [h]ighlight' },
    -- Trevj. this uh splits lists etc into lines? That's what it seems like at least
    { '<A-j>', require('trevj').format_at_cursor, desc = 'breakout list to lines' },

    -- Molten. Run Jupyter notebooks
    { '<leader>M', desc = 'Molten (Jupyter)' },
    { '<leader>Mi', ':MoltenInit<CR>', desc = 'Initialize the plugin' },
    { '<leader>Me', ':MoltenEvaluateOperator<CR>', desc = 'run operator selection' },
    { '<localleader>Ml', ':MoltenEvaluateLine<CR>', desc = 'evaluate line' },
    { '<leader>Mr', ':MoltenReevaluateCell<CR>', desc = 're-evaluate cell' },
    { '<leader>Ms', ':<C-u>MoltenEvaluateVisual<CR>gv', desc = 'evaluate visual selection' },

    -- Referencer.
    { '<leader>e', desc = 'Referencer Toggle' },
    { '<leader>et', '<cmd>ReferencerToggle<cr>', desc = 'Referencer Toggle' },
    { '<leader>eu', '<cmd>ReferencerUpdate<cr>', desc = 'Referencer Update' },

    -- nvim-macros
    { '<leader>mw', ':MacroSave<cr>', desc = 'Save Macro' },
    { '<leader>my', ':MacroYank<cr>', desc = 'Yank Macro (register)' },
    { '<leader>ms', ':MacroSelect<cr>', desc = 'Select Saved Macro' },

    -- Grug-Far
    { 'gF', grug.open, desc = 'GrugFar Replace' },
    { 'gW', '<cmd>GrugFarWithin<cr>', desc = 'GrugFar Replace Within Range' },
    -- Render-Markdown
    { 'gm', cmd 'RenderMarkdown toggle', desc = 'Render Markdown' },
    -- todo-comments:
    { '<leader>2', desc = 'Todo-Comments' },
    { '<leader>2d', '<cmd>TodoTelescope<cr>', desc = 'Search Todo Comments' },
    { '<leader>2q', '<cmd>TodoTrouble<cr>', desc = 'List Todo in Quickfix' },
    -- no-neck-pain:
    { '<leader>n', desc = '[N]oNeckPain' },
    { '<leader>nn', '<cmd>NoNeckPain<cr>', desc = 'Toggle NNP (On)/Off' }, -- TODO: disable minwidth
    { '<leader>nr', '<cmd>NoNeckPainToggleRightSide<cr>', desc = '(Toggle Right)' },
    { '<leader>nl', '<cmd>NoNeckPainToggleLeftSide<cr>', desc = '(Toggle Left)' },
    { '<leader>nu', Map.nnp_resize(4), desc = '(Width+)' },
    { '<leader>nU', Map.nnp_resize(1), desc = '(Width+ precise)' },
    { '<leader>nd', Map.nnp_resize(-4), desc = '(Width-)' },
    { '<leader>nd', Map.nnp_resize(-1), desc = '(Width- precise)' },

    -- zen mode
    {
      '<leader>uz',
      function()
        require('zen-mode').toggle {
          -- window = {
          --   backdrop = 0.9,
          --   width = 0.50, -- 0.8 = 80% win width, 80 = 80 chars
          -- },
        }
      end,
      desc = '[u]til: [z]en mode',
    },
    --DividerLine
    { '<leader>ud', require('divider').toggle_outline, desc = 'Open Dividerline Sidebar' },
  }
  return m
end
function Map.leap()
  return {
    { 'S', '<Plug>(leap-anywhere)', desc = 'leap anywhere' },
    { '<C-s>', '<Plug>(leap)', desc = 'leap', mode = { 'i', 'n' } },
  }
end
function Map.nnp_resize(size)
  return function()
    if size > 0 then
      for _ = 1, size do
        vim.cmd 'NoNeckPainWidthUp'
      end
    elseif size < 0 then
      for _ = 1, -size do
        vim.cmd 'NoNeckPainWidthDown'
      end
    end
  end
end
-- ╭──────────────╮
-- │ not used yet │
-- ╰──────────────╯
-- function Map.CustomEqualWindowSize()
--   -- fix any windows needed:
--   ---> no-neck-pain
--   -- make equal:
--   vim.o.equalalways = true
--   vim.o.equalalways = false
-- end

function Map.hover()
  -- Setup keymaps
  vim.o.mousemoveevent = true
  return {
    mode = 'n',
    { 'K', require('hover').open, desc = 'hover.nvim' },
    { 'gK', require('hover').select, desc = 'hover.nvim (select)' },
    {
      '<C-p>',
      function()
        require('hover').switch 'previous'
      end,
      desc = 'hover.nvim (previous source)',
    },
    {
      '<C-n>',
      function()
        require('hover').switch 'next'
      end,
      desc = 'hover.nvim (previous source)',
    },
    { '<MouseMove>', require('hover').mouse, desc = 'hover.nvim (mouse)' },
  }
  --[[ vim.keymap.set('n', 'K', require('hover').hover, { desc = 'hover.nvim' }) -- replace default hover
  vim.keymap.set('n', 'gK', require('hover').hover_select, { desc = 'hover.nvim (select)' }) -- new?
  vim.keymap.set('n', '<C-p>', function()
    require('hover').hover_switch 'previous'
  end, { desc = 'hover.nvim (previous source)' })
  vim.keymap.set('n', '<C-n>', function()
    require('hover').hover_switch 'next'
  end, { desc = 'hover.nvim (next source)' })
  vim.keymap.set('n', '<MouseMove>', require('hover').hover_mouse, { desc = 'hover.nvim (mouse)' })
]]
  -- Mouse support - eh why not
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
