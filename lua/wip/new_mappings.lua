local Map = {}
-- ─────── FUNCTIONS TO MOVE OVER TO NEWMAP_FUNCTIONS.LUA ─────────────────────────
-- ────────────────────────────────────────────────────────────────────────────────

--- Mapping Functions:
local function wkMapFromTable(mtable)
  local wk = require 'which-key'
  if mtable.spec then
    wk.add(mtable.spec, mtable.opts or {})
  else
    for k, mapping in pairs(mtable) do
      if type(k) == 'string' then
        mapping.group = k
      end
      wk.add(mapping)
    end
  end
end

function Map.all_plugins()
  local mapfn = require 'plugins.map_functions'
  local m = { -- primary mappings table
    vim = {
      { '<leader>q', vim.diagnostic.setloclist, desc = 'Quickfix list' },
      { '<Esc>', '<cmd>nohlsearch<CR>' },
      { '<C-h>', '<C-w><C-h>', desc = 'Move focus to the left window' },
      { '<C-k>', '<C-w><C-k>', desc = 'Move focus to the upper window' },
      { '<C-l>', '<C-w><C-l>', desc = 'Move focus to the right window' },
      { '<C-j>', '<C-w><C-j>', desc = 'Move focus to the lower window' },
      { '|', '<cmd>lua MiniFiles.open()<CR>', desc = 'MiniFiles open' },
      { '<M-\\>', mapfn.toggletermFlip, desc = 'ToggleTerm Flip' },
      { '<M-h>', mapfn.tabpage_prev, desc = 'previous tabpage' },
      { '<M-l>', mapfn.tabpage_next, desc = 'next tabpage' },
      {
        '<leader>vb',
        function()
          local b = 'name:[' .. vim.fn.bufname() .. ']\nnum: ' .. vim.fn.bufnr()
          vim.print(b)
        end,
        desc = 'Vim: print current buffer detail',
      },
      { 'gl', vim.lsp.buf.incoming_calls(), desc = 'show incoming calls to symbol under cursor' },
    },
    labels_whichkey = {
      { '<leader>?', group = '[which-key]' },
      --{ '<leader>a', group = '[A]pp' },
      { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
      { '<leader>cs', group = '[C]ode [S]ymbols', mode = { 'n', 'x' } },
      { '<leader>d', group = '[D]ocument' },
      { '<leader>r', group = '[R]ename' },
      { '<leader>s', group = '[S]earch' },
      { '<leader>w', group = '[W]orkspace' },
      { '<leader>t', group = '[T]oggle' },
      { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      { '<leader>g', group = '[G]it', mode = { 'n', 'v' } },
      { '<leader>x', group = 'Trouble' },
      { '<leader>um', desc = 'miss.nvim' },
    },

    vim_custom = {
      { '<A-r>', ':lua<CR>', desc = 'run selected lua code', mode = 'v' },
      go = {
        { '<leader>l', group = '[L]anguage functions', mode = { 'n', 'v' } }, --[WhichKey Label]
        { '<leader>lr', '<cmd>GoRun<CR>', desc = 'Go Run' },
        { '<leader>ld', '<cmd>GoDoc<CR>', desc = 'GoDoc lookup' },
        { '<leader>lD', '<cmd>GoSearch<CR>', desc = 'GoSearch (godoc.nvim)' },
        { '<leader>la', '<cmd>GoAlt<CR>', desc = 'Toggle to test file' },
        { '<leader>lf', '<cmd>GoRun -F<CR>', desc = 'Go Run Floating window' },
        { '<leader>lb', '<cmd>GoBuild<CR>', desc = 'Go Build to cwd' },
        { '<leader>lt', '<cmd>GoTest -n<CR>', desc = 'Go Test selected' },
        { '<leader>lm', '<cmd>GoModTidy<CR>', desc = 'Go Mod Tidy' },
        { '<leader>ln', '<cmd>GoRename<CR>', desc = 'Go Rename symbol' },
        { '<leader>lI', '<cmd>GoImpl<CR>', desc = 'GoImpl' },
      },
      persistence = {
        { '<leader>p', group = '[P]ersist' }, --[WhichKey Label]
        { '<leader>ps', require('persistence').load, desc = 'Load cwd session' },
        { '<leader>pS', require('persistence').select, desc = 'Select session' },
        {
          '<leader>pl',
          function()
            require('persistence').load { last = true }
          end,
          desc = 'Load last session',
        },
        { '<leader>pd', require('persistence').stop, desc = 'Disable session save' },
      },
      { '<leader>u', group = '[U]tility' },
      icon_picker = {
        { '<Leader>ui', '<cmd>IconPickerNormal<cr>' },
      },
      precognition = { '<leader>up', require('precognition').toggle, desc = '[U]til: [p]recognition toggle' },
      aerial = { '<leader>ua', require('aerial').open, desc = '[U]til: [a]erial' },
      ccc = { '<leader>uc', '<cmd>CccPicker<CR>', desc = '[U]til: [c]cc colorpicker' },
      trevj = { '<A-j>', require('trevj').format_at_cursor, desc = 'breakout list to lines' }, -- splits lists, functions, etc into lines
      render_markdown = { 'gm', '<cmd>RenderMarkdown toggle<CR>', desc = 'Render Markdown' }, -- Render-Markdown
      lspsaga = {
        { '<leader>o', '<cmd>Lspsaga outline<CR>', desc = '[o]utline Lspsaga' },
        { '<leader>d', '<cmd>Lspsaga diagnostic<CR>', desc = '[d]iagnostic Lspsaga' },
      },
      tinygit = {
        { '<leader>ga', require('tinygit').interactiveStaging, desc = 'git add' },
        { '<leader>gc', require('tinygit').smartCommit, desc = 'git commit' },
        { '<leader>gp', require('tinygit').push, desc = 'git push' },
        {
          '<leader>gI',
          function()
            require('tinygit').issuesAndPrs { type = 'all', state = 'all' }
          end,
          desc = 'search Github issues + Pull Requests',
        },
        { '<leader>gh', require('tinygit').fileHistory, desc = 'search file history' },
      },
      neogit = {
        { '<leader>gn', require('neogit').open, desc = 'Neogit' },
        {
          '<leader>gm',
          function()
            require('neogit').open { kind = 'vsplit' }
          end,
          desc = 'Neogit in vsplit',
        },
      },
      diffview = {
        { '<leader>gd', require('diffview').open, desc = 'open diffview' },
      },
      -- inc_rename: provided function does not work: { 'gR', function() return ':IncRename ' .. vim.fn.expand '<cword>' end, desc = 'iRename symbol', },
      inc_rename = { 'gR', ':IncRename ', desc = 'Start IncRename' },
      hover = {
        { 'K', require('hover').hover, { desc = 'hover.nvim' } }, -- replace default hover
        { 'gK', require('hover').hover_select, { desc = 'hover.nvim (select)' } },
        { '<MouseMove>', require('hover').hover_mouse, { desc = 'hover.nvim (mouse)' } },
        {
          '<C-p>',
          function()
            require('hover').hover_switch 'previous'
          end,
          desc = 'hover.nvim (previous source)',
        },
        {
          '<C-n>',
          function()
            require('hover').hover_switch 'next'
          end,
          desc = 'hover.nvim (next source)',
        },
      },

      leap = {
        { 'S', '<Plug>(leap-anywhere)', desc = 'leap anywhere' },
        { '<C-s>', '<Plug>(leap)', desc = 'leap', mode = { 'i', 'n' } },
      },

      comment_box = {
        -- see M.commentbox() for notes
        { 'gCb', '<cmd>CBlcbox 1<CR>' },
        { 'gCl', '<cmd>CBllline 1<CR>' },
        { 'gCs', '<cmd>CBlcbox 2<CR>' },
        { 'gCq', '<cmd>CBlcline 2<CR>' },
      },
      obs = {
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
      },
    },
  }
  -- potential setup stuff:

  -- disable mapping tables:
  local DISABLED = { 'hover', 'obs' }
  for key, _ in pairs(m) do
    for _, name in ipairs(DISABLED) do
      if name == key then
        m[key] = nil
      end
    end
  end
  wkMapFromTable(m)
end
return Map
