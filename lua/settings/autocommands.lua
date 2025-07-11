--# Helpers (no want write long)
local auto = vim.api.nvim_create_autocmd
local agnames = {}
local make_augroup = function(name)
  table.insert(agnames, name)
  return vim.api.nvim_create_augroup(name, { clear = true })
end

-- Control which hover is being used
-- vim basic, lspsaga, or hover.nvim (as of now)
local hovr = { num = 2, selected = 'saga' }
hovr.next = function()
  hovr.sethover(hovr.num + 1)
end
hovr.prev = function()
  hovr.sethover(hovr.num - 1)
end
function hovr.setnum(i)
  hovr.num = ((i - 1) % 3) + 1 --  +1 cuz lua index starts at 1
end
function hovr.update_selection()
  local methodmap = { 'vim', 'saga', 'hover.nvim' }
  hovr.selected = methodmap[hovr.num]
end

local hoverselect = function()
  if hovr.selected then
    if hovr.selected == 'vim' then
    elseif hovr.selected == 'saga' then
    elseif hovr.selected == 'hover.nvim' then
    end
  end
end

local M = {
  opts = {
    hover = true, -- enable/disable hover popup
  },
}
local function persistAuto() -- why is this separate
  -- `PersistenceSavePre` before saving a session, `PersistenceSavePost` after saving a session
  vim.api.nvim_create_autocmd('User', {
    pattern = 'PersistenceSavePre',
    desc = 'Avoid saving open neotree window',
    group = make_augroup 'persistence-save',
    callback = function()
      require('neo-tree.command').execute { action = 'close' }
    end,
  })
end

--  ┌─────────────────────────[ MAKE AUTOCOMMANDS ]─────────────────────────┐
local function autocmd()
  -- ── Autocommand-related mapping ───────────────────
  -- toggle hover
  --( NOT NEEDED: Use K (<S-k>))
  --[[ vim.keymap.set('n', 'gh', function()
    M.opts.hover = not M.opts.hover
  end, { desc = 'toggle hover popup' }) ]]
  --  ── [0] quick startup auto ──────────────────────────────────────────────
  auto('VimEnter', {
    desc = 'run whaler, would prefer both persistence and whaler',
    group = make_augroup 'startup-greet',
    callback = function()
      --require('persistence').select()
      require('telescope').extensions.whaler.whaler()
    end,
  })
  --  ── [1] highlight on yank ───────────────────────────────────────────────
  auto('TextYankPost', { -- Try it with `yap` in normal mode
    desc = 'Highlight when yanking (copying) text', --See`:help vim.highlight.on_yank()`
    group = make_augroup 'highlight-yank',
    callback = function()
      vim.highlight.on_yank()
    end,
  })
  --  ── [2] resize splits on window resize ─────────────────────────────── TODO: check if this is the source of resizing left-only
  auto({ 'VimResized' }, {
    group = make_augroup 'resize-splits',
    callback = function()
      local current_tab = vim.fn.tabpagenr()
      vim.cmd 'tabdo wincmd ='
      vim.cmd('tabnext ' .. current_tab)
    end,
  })
  -- ── [3] delete tmp shada on shada lockup ────────────────────────────────
  auto({ 'VimLeave' }, {
    group = make_augroup 'on-dirty-exit',
    callback = function()
      if vim.v.dying and string.sub(vim.v.errmsg, 1, 4) == 'E138' then
        local shdir = vim.fn.stdpath 'data' .. '\\shada'
        local shadas = vim.fn.globpath(shdir, '*.tmp.*', false, true)
        for _, v in pairs(shadas) do -- deletes all shada tmp files
          vim.fn.delete(v)
        end
      end
    end,
  })
  -- ── [4] make lsp autocommands on attach ───────────────────────────────── NOTE: time to hang it up; for now at least
  -- auto('LspAttach', {
  --   group = ag 'lsp-attached-setauto',
  --   callback = function() --──────────────── LSP ACTIVE ENTERED ───
  --     -- ───────────────────────── [4a] idle hover popup ───────────────────────
  --     auto('CursorHold', {
  --       group = ag 'lsp-hover-custom',
  --       callback = function()
  --         if M.opts.hover then -- best way to set this up?
  --           require('hover').hover()
  --           --[[ vim.lsp.buf.hover {
  --             max_height = 40,
  --             max_width = 160,
  --             --offset_x = 4, -- offset defaults probably 0
  --             --offset_y = 2,
  --             --zindex = 50, -- default 50, is forward/back. keep here
  --             anchor_bias = 'auto', --auto|above|below
  --             relative = 'cursor', --cursor|mouse|editor
  --             focus = false,
  --             silent = true,
  --             --not the biggest fan of border but damn does it make shit easier
  --             -- "none", "single"(line), "double", "rounded", "solid"(block), "shadow"
  --             border = 'none', -- shadow would be best; it has issues
  --
  --             --close_events = {''} --idk defaults,
  --           } ]]
  --         end
  --       end,
  --     })
  --   end,
  -- })
  -- ── [5] clear lsp autocommands on detach ────────────────────────────────
  -- auto('LspDetach', {
  --   group = ag 'lsp-detached-setauto',
  --   callback = function()
  --     auto('CursorHold', {
  --       group = ag 'lsp-hover-custom', -- should clear hover auto
  --       callback = function() end,
  --       -- no need to disable hover key really
  --     })
  --   end,
  -- })
  -- ── [6] Adds close with q to specified windows ──────────────────────────
  auto('FileType', {
    group = make_augroup 'close_with_q',
    pattern = {
      'PlenaryTestPopup',
      'checkhealth',
      'dbout',
      'gitsigns-blame',
      'grug-far',
      'help',
      'lspinfo',
      'neotest-output',
      'neotest-output-panel',
      'neotest-summary',
      'notify',
      'qf',
      'spectre_panel',
      'startuptime',
      'tsplayground',
      '*\\*_luapad.lua',
      'diffview',
    },
    callback = function(event)
      vim.bo[event.buf].buflisted = false
      -- TODO: learn how vim.schedule works!
      vim.schedule(function() -- runs this until it gets a true?
        vim.keymap.set('n', 'q', function()
          vim.cmd 'close'
          pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
        end, {
          buffer = event.buf,
          silent = true,
          desc = 'Quit buffer',
        })
      end)
    end,
  })

  -- ── [7] Improve Colorscheme when loaded ─────────────────────────────────
  vim.api.nvim_create_autocmd('Colorscheme', {
    group = make_augroup 'theme-change-apply',
    callback = function()
      -- when a theme has black bg winbar, the table is always the same
      local badWinBar = { bg = 460813, bold = true, cterm = { bold = true }, fg = 10198692 }
      local currentWinBar = vim.api.nvim_get_hl(0, { name = 'WinBar' })
      local normal = vim.api.nvim_get_hl(0, { name = 'Normal' })
      local normNC = vim.api.nvim_get_hl(0, { name = 'NormalNC' })
      if currentWinBar.bg == badWinBar.bg and currentWinBar.fg == badWinBar.fg then
        vim.api.nvim_set_hl(0, 'WinBar', { bg = 'bg', fg = 'fg' })
        local normal = vim.api.nvim_get_hl(0, { name = 'Normal' })
        vim.cmd "highlight WinBar guibg='bg' guifg='fg' gui='italic'"
        vim.cmd "highlight WinBarNC guibg='bg'"
      end
      --* taking the opportunity to spruce things up -> badWinBar
      --TODO: implement unfocused buffer color dim/fade
      --[[ if normal==normNC then
         
      end ]]
    end,
  })

  --TODO: add q to quit for scratch bufs
  --TODO: Recolor minibar when recording
  --- pattern = filename
  --- reg_recording() = current register in use
  -- auto ('RecordingEnter')

  -- ─────┤ Template: changes commands on switching to diff filtype ├─────
  -- Dirty method to pull filetype. whatever
  vim.api.nvim_create_autocmd({ 'BufEnter' }, { -- , 'FileType'
    group = make_augroup 'filetype_change',
    --pattern = { '*.md' },
    callback = function(event)
      local pos = event.match:find '.md'
      if pos and pos == event.match:len() - 2 then
        vim.o.conceallevel = 1
        --do the thing obsidian plugin needs or whatever
        --vim.o.
      else
      end
    end,
  })
end

--- Change options for specific autocommands
---@param options any
function M.setoptions(options)
  vim.tbl_deep_extend 'force'
end

--- Make all autocommands
function M.post_autocmd()
  persistAuto()
  autocmd()
end

-- Delete/Clear all personally-created autogroups and autocmmands
function M.wipe_autos()
  local autocommands = vim.api.nvim_get_autocmds {}
  local clearable = {}

  for i, ac in ipairs(autocommands) do
    for _, gname in ipairs(agnames) do
      if ac.group_name == gname then
        table.insert(clearable, ac.group_name)
      end
    end
  end

  for _, grp in ipairs(clearable) do
    vim.api.nvim_del_augroup_by_name(grp)
  end
end

return M
