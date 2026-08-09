-- mapping helper functions
local function cmd(s)
  return '<cmd>' .. s .. '<CR>'
end

local vimfunc = require 'settings.vim_functionality'

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
    --vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
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
  vismode = {},
  --NOTE: Thinking all mappings should be after lazy init?
  --      I don't think descriptions here go to which-key.
  --      Which-key description for go mappings is just using command name
  assigns = {
    { '<leader>w', require('settings.vim_functionality').format_and_save, desc = 'Format and save file' },
    -- trouble TODO: fix these binds
    { '<leader>q', vim.diagnostic.setloclist, desc = 'Quickfix list' },
    { '<Esc>', '<cmd>nohlsearch<CR>' },
    { '<C-h>', '<C-w><C-h>', desc = 'Move focus to the left window' },
    { '<C-k>', '<C-w><C-k>', desc = 'Move focus to the upper window' },
    { '<C-l>', '<C-w><C-l>', desc = 'Move focus to the right window' },
    { '<C-j>', '<C-w><C-j>', desc = 'Move focus to the lower window' },
    --NOTE: Replacing Neo-tree due to neo-tree lsp problems
    --NOTE: Replacing minifiles cuz it makes it too easy to just completely erase shit
    --NOTE: NvimTree is annoying I just want my neotree setup but in a way that doesn't fuck up lsp
    --NOTE Now I am going to Neo-tree and hoping it fucking works
    -- { '\\', cmd 'lua MiniFiles.open()', desc = 'MiniFiles open' },
    -- { '\\', cmd 'NvimTreeToggle', desc = 'NvimTree Toggle' },
    -- { '\\', cmd 'Fyler kind=float', desc = 'Fyler' },
     {'|', cmd 'ClaudeCode', desc = 'Open ClaudeCode Terminal' },
    { '\\', cmd 'Neotree toggle=true', desc = 'Neo-Tree Toggle' },
    --hoping this will open wk
    { '<M-\\>', desc = 'ToggleTerm Mode' },
    { '<M-\\>h', toggleterm_mode 'h', desc = 'ToggleTerm Mode horizontal' },
    { '<M-\\>v', toggleterm_mode 'v', desc = 'ToggleTerm Mode vertical' },
    { '<M-\\>f', toggleterm_mode 'f', desc = 'ToggleTerm Mode float' },
    { '<M-\\>t', toggleterm_mode 't', desc = 'ToggleTerm Mode tab' },
    { '<M-h>', tabpage_prev, desc = 'previous tabpage' },
    { '<M-l>', tabpage_next, desc = 'next tabpage' },
    -- ── Custom Functions ────────────────────────────────────────────────
    { '<leader>vb', vimfunc.print_buf_detail, desc = 'Vim: print current buffer detail' },
    { '<Tab>', vimfunc.switchToLastBuffer, desc = 'Vim: switch to last buffer' },
    {
      '<C-w>f',
      function()
        vim.g.neovide_scale_factor = (vim.g.neovide_scale_factor or 1.0) - 0.04
      end,
      desc = 'neovide scale ',
    },

    {
      '<C-w>F',
      function()
        vim.g.neovide_scale_factor = (vim.g.neovide_scale_factor or 1.0) + 0.04
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
      { '<leader>ps', pr.load, desc = 'Load cwd session' },
      { '<leader>pS', pr.select, desc = 'Select session' },
      {
        '<leader>pl',
        function()
          pr.load { last = true }
        end,
        desc = 'Load last session',
      },
      { '<leader>pd', pr.stop, desc = 'Disable session save' },
    },
  }
  Map.wk.add({ { '<Leader>ui', '<cmd>IconPickerNormal<cr>', desc = 'Icon Picker 💪' } }, { silent = true })
  local mappingFunctions = {
    Map.gitplugins,
    Map.other_plugins,
    Map.leap,
    Map.commentbox,
    Map.telescope,
    Map.neovide,
    Map.vim,
  }
  for _, mfn in ipairs(mappingFunctions) do
    Map.wk.add(mfn())
  end
end

function Map.vim()
  local m = {
    { '<A-r>', ':lua<CR>', mode = 'v', desc = 'run selected lua code' },
    { 'gl', vim.lsp.buf.incoming_calls, desc = 'show incoming calls to symbol under cursor' },
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
  local neogit = require 'neogit'
  return {
    { '<leader>gn', neogit.open, desc = 'Neogit' },
    {
      '<leader>gm',
      function()
        neogit.open { kind = 'vsplit' }
      end,
      desc = 'Neogit in vsplit',
    },
    -- Need to add context or this will just open the full project diffview
    { '<leader>gd', require('diffview').open, desc = 'open diffview' },
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
  -- local precog = require 'precognition'
  local grug = require 'grug-far'
  local aerial = require 'aerial'
  -- local dropbar_api = require 'dropbar.api'
  -- vim.keymap.set('n', '<Leader>;', dropbar_api.pick, { desc = 'Pick symbols in winbar' })
  -- vim.keymap.set('n', '[;', dropbar_api.goto_context_start, { desc = 'Go to start of current context' })
  -- vim.keymap.set('n', '];', dropbar_api.select_next_context, { desc = 'Select next context' })
  local m = {
    -- Bufferline:
    { 'g<CR>', '<cmd>BufferLinePick<cr>', desc = 'Switch Buffer (Line)' },
    { 'g<BS>', '<cmd>BufferLinePickClose<cr>', desc = 'Close Buffer (Line)' },
    -- Precognition (REMOVED)
    -- { '<leader>up', precog.toggle, desc = '[U]til: [p]recognition toggle' },
    -- Aerial
    --{ '<leader>ua', aerial.open, desc = '[U]til: [a]erial' },
    { '<leader>ua', aerial.toggle, desc = '[U]til: [a]erial' },
    -- Outline (in outline config in aerial.lua)
    -- Ccc
    { '<leader>uc', cmd 'CccPick', desc = '[U]til: [c]cc colorpicker' },
    { '<leader>uh', cmd 'CccHighlighterToggle', desc = '[U]til: ccc color [h]ighlight' },
    -- Trevj. this uh splits lists etc into lines? That's what it seems like at least

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

    -- nvim-macros: NOT INSTALLED, these commands do not exist.
    -- Macros are handled by macrothis.nvim (trials/macrothis.lua) on <leader>kk*
    -- { '<leader>mw', ':MacroSave<cr>', desc = 'Save Macro' },
    -- { '<leader>my', ':MacroYank<cr>', desc = 'Yank Macro (register)' },
    -- { '<leader>ms', ':MacroSelect<cr>', desc = 'Select Saved Macro' },

    -- Grug-Far
    { 'gF', grug.open, desc = 'GrugFar Replace' },
    { 'gW', '<cmd>GrugFarWithin<cr>', desc = 'GrugFar Replace Within Range' },
    -- Render-Markdown: 'plugins.markdown' is commented out in dlazyinit, so
    -- :RenderMarkdown does not exist. Re-enable that module to use this.
    -- { 'gm', cmd 'RenderMarkdown toggle', desc = 'Render Markdown' },
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
    { '<leader>nd', Map.nnp_resize(-2), desc = '(Width-)' },
    { '<leader>nD', Map.nnp_resize(-4), desc = '(Width- precise)' },

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
    --DividerLine (removed)
    -- { '<leader>ud', require('divider').toggle_outline, desc = 'Open Dividerline Sidebar' },
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
function Map.telescope()
  local telescope = require 'telescope'
  local builtin = require 'telescope.builtin'
  local themes = require 'telescope.themes'
  local function ext(name, picker)
    return function()
      local e = telescope.extensions[name]
      if not (e and e[picker]) then
        vim.notify('telescope extension not loaded: ' .. name, vim.log.levels.WARN)
        return
      end
      e[picker]()
    end
  end
  return {
    { '<leader><leader>', builtin.buffers, desc = '[ ] Find existing buffers' },
    { '<leader>sh', builtin.help_tags, desc = '[S]earch [H]elp' },
    { '<leader>sk', builtin.keymaps, desc = '[S]earch [K]eymaps' },
    { '<leader>sf', builtin.find_files, desc = '[S]earch [F]iles' },
    { '<leader>ss', builtin.builtin, desc = '[S]earch [S]elect Telescope' },
    { '<leader>sw', builtin.grep_string, desc = '[S]earch current [W]ord' },
    { '<leader>sg', builtin.live_grep, desc = '[S]earch by [G]rep' },
    { '<leader>sd', builtin.diagnostics, desc = '[S]earch [D]iagnostics' },
    { '<leader>sr', builtin.resume, desc = 'last [S]earch [R]esume' },
    { '<leader>s.', builtin.oldfiles, desc = '[S]earch Recent Files' },
    { '<leader>sT', builtin.tags, desc = '[S]earch [T]ags' },
    { '<leader>sq', builtin.quickfix, desc = '[S]earch [Q]uickfix' },
    { '<leader>sD', builtin.lsp_definitions, desc = '[S]earch lsp [D]efinitions' },
    { '<leader>st', builtin.treesitter, desc = '[S]earch [t]reesitter' },
    { '<leader>sz', ext('zoxide', 'list'), desc = '[S]earch [z]oxide list' },
    { '<leader>sH', ext('helpgrep', 'helpgrep'), desc = '[S]earch [H]elp with grep' },
    { '<leader>sl', ext('luasnip', 'luasnip'), desc = '[S]earch [l]uasnip snippets' },
    { '<leader>sc', builtin.colorscheme, desc = '[S]earch [C]olorschemes' },
    { '<leader>sb', builtin.git_bcommits, desc = '[S]earch [B]uffer Commit History' },
    { '<leader>sR', builtin.reloader, desc = '[S]earch [R]eloader' },
    { 'gI', builtin.lsp_implementations, desc = 'LSP:[G]oto [I]mplementation(s)' },
    { '<leader>uu', '<cmd>Telescope unicode_picker<CR>', desc = 'Unicode Picker' },
    {
      '<leader>/',
      function()
        builtin.current_buffer_fuzzy_find(themes.get_dropdown { winblend = 10, previewer = false })
      end,
      desc = '[/] Fuzzily search in current buffer',
    },
    {
      '<leader>s/',
      function()
        builtin.live_grep { grep_open_files = true, prompt_title = 'Live Grep in Open Files' }
      end,
      desc = '[S]earch [/] in Open Files',
    },
    {
      '<leader>sn',
      function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end,
      desc = '[S]earch [N]eovim files',
    },
    {
      '<leader>so',
      function()
        local vault = vim.fn.expand(vim.g.dvault or '~/OneDrive/Apps/remotely-save/DVAULT/')
        if vim.fn.isdirectory(vault) == 0 then
          vim.notify('Obsidian vault not found: ' .. vault .. '\nset vim.g.dvault', vim.log.levels.WARN)
          return
        end
        builtin.find_files { cwd = vault }
      end,
      desc = '[S]earch [O]bsidian notes',
    },
  }
end

return Map
