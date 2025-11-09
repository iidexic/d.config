--# Helpers (no want write long)
local auto = vim.api.nvim_create_autocmd
local ag = function(name)
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
    group = vim.api.nvim_create_augroup('persistence-save', { clear = true }),
    callback = function()
      require('neo-tree.command').execute { action = 'close' }
    end,
  })
end

--  ┌─────────────────────────[ MAKE AUTOCOMMANDS ]─────────────────────────┐
local function autocmd()
  --  ── [0] quick startup auto ──────────────────────────────────────────────
  --  TODO: only run if no file. Or just add a startup plugin/snacks
  auto('VimEnter', {
    desc = 'run whaler, would prefer both persistence and whaler',
    group = ag 'startup-greet',
    callback = function()
      --require('persistence').select()
      require('telescope').extensions.whaler.whaler()
    end,
  })
  --  ── [1] highlight on yank ───────────────────────────────────────────────
  auto('TextYankPost', { -- Try it with `yap` in normal mode
    desc = 'Highlight when yanking (copying) text', --See`:help vim.highlight.on_yank()`
    group = ag 'highlight-yank',
    callback = function()
      vim.highlight.on_yank()
    end,
  })
  --  ── [2] resize splits on window resize ─────────────────────────────── TODO: check if this is the source of resizing left-only
  auto({ 'VimResized' }, {
    group = ag 'resize-splits',
    callback = function()
      local current_tab = vim.fn.tabpagenr()
      vim.cmd 'tabdo wincmd ='
      vim.cmd('tabnext ' .. current_tab)
    end,
  })
  -- ── [3] delete tmp shada on shada lockup ────────────────────────────────
  auto({ 'VimLeave' }, {
    group = ag 'on-dirty-exit',
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
  --   callback = function()
  --   end,
  -- })
  -- ── [5] clear lsp autocommands on detach ────────────────────────────────
  -- auto('LspDetach', { group = ag 'lsp-detached-setauto', callback = function() end, })
  -- ── [6] Adds close with q to specified windows ──────────────────────────
  auto('FileType', {
    group = ag 'close_with_q',
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
      vim.schedule(function()
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

  --TODO: add q to quit for scratch bufs
  --TODO: Recolor minibar when recording
  --- pattern = filename
  --- reg_recording() = current register in use
  -- auto ('RecordingEnter')

  -- ─────┤ Template: changes commands on switching to diff filtype ├─────
  -- Dirty method to pull filetype. whatever
  vim.api.nvim_create_autocmd({ 'BufEnter' }, { -- , 'FileType'
    group = vim.api.nvim_create_augroup('filetype_change', { clear = true }),
    --pattern = { '*.md' },
    callback = function(event)
      local pos = event.match:find '.md'
      if pos and pos == event.match:len() - 2 then
        vim.o.conceallevel = 1
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

function M.wipe_autos()
  local clear_these = {
    { event = 'User', groupname = 'persistence-save' },
    { event = 'VimEnter', groupname = 'startup-greet' },
    { event = 'TextYankPost', groupname = 'highlight-yank' },
    { event = 'VimResized', groupname = 'resize-splits' },
    { event = 'VimLeave', groupname = 'on-dirty-exit' },
    { event = 'LspAttach', groupname = 'lsp-attached-setauto' },
    { event = 'LspDetach', groupname = 'lsp-detached-setauto' },
    { event = 'FileType', groupname = 'close_with_q' },
    { event = 'BufEnter', groupname = 'filetype_change' },
  }
  for _, tbl in ipairs(clear_these) do
    vim.api.nvim_create_autocmd(tbl.event, { group = tbl.groupname })
  end
end

return M
