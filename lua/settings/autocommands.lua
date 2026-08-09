--# Helpers (no want write long)
local auto = vim.api.nvim_create_autocmd
local agnames = {}
local make_augroup = require('settings.vim_util').autogroup
-- local make_augroup = function(name) table.insert(agnames, name); return vim.api.nvim_create_augroup(name, { clear = true }) end

-- NOTE: lsp autocommands are in autocommands_lsp.lua
-- NOTE: autocommands to control/change hover provider (and corresponding settings) have been removed

local M = {}
local fp = require 'util.filepath'

-- Close side panels before persistence writes a session, so they don't get
-- restored as empty/broken splits on the next load.
local function persistAuto()
  auto('User', {
    pattern = 'PersistenceSavePre',
    desc = 'eliminate unwanted buffers before saving',
    group = make_augroup 'pre-save-buffer-elimination',
    callback = function()
      -- NNP's disable() is debounced (vim.schedule'd), so a pcall here would only
      -- wrap the scheduling — an error inside main.disable escapes it. Calling it
      -- while disabled throws (state.tabs[active_tab] is nil), so mirror the guard
      -- the plugin's own public API uses. Reading the global instead of requiring
      -- also avoids force-loading NNP on every save when it was never used.
      if _G.NoNeckPain ~= nil and _G.NoNeckPain.state ~= nil and _G.NoNeckPain.state.enabled then
        require('no-neck-pain').disable()
      end
      pcall(function() require('outline').close() end)
      pcall(function() require('aerial').close() end)
    end,
  })
end

--  ┌─────────────────────────[ MAKE AUTOCOMMANDS ]─────────────────────────┐
local function autocmd()
  -- ── Autocommand-related mapping ───────────────────
  -- NOTE: hover autocommands removed
  --  ── [0] quick startup auto ──────────────────────────────────────────────
  auto('VimEnter', {
    desc = 'run zoxide on startup if not in file',
    group = make_augroup 'startup-greet',
    callback = function()
      if vim.bo.filetype ~= '' then
        return
      end
      local ok_t, telescope = pcall(require, 'telescope')
      if ok_t and telescope.extensions and telescope.extensions.zoxide then
        telescope.extensions.zoxide.list()
      end
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

  --  ── [2] resize splits on window resize ───────────────────────────────────
  auto({ 'VimResized' }, {
    group = make_augroup 'resize-splits',
    callback = function()
      local current_tab = vim.fn.tabpagenr()
      vim.cmd 'tabdo wincmd ='
      vim.cmd('tabnext ' .. current_tab)
    end,
  })

  -- ── [3] log errors / clean shada tmp files on exit ──────────────────────
  -- NOTE: vim.v.dying is only set for fatal-signal exits, not normal-exit
  -- errors like E138, so we gate on v:errmsg instead.
  auto('VimLeavePre', {
    group = make_augroup 'on-dirty-exit',
    callback = function()
      local err = vim.v.errmsg
      if err == nil or err == '' then
        return
      end
      if err:sub(1, 4) == 'E138' then
        local shdir = vim.fs.joinpath(vim.fn.stdpath 'data', 'shada')
        for _, v in pairs(vim.fn.globpath(shdir, '*.tmp.*', false, true)) do
          vim.fn.delete(v)
        end
        return
      end
      local logdir = vim.fs.joinpath(vim.fn.stdpath 'data', 'logs')
      vim.fn.mkdir(logdir, 'p')
      local log = io.open(vim.fs.joinpath(logdir, 'nvim-dirty-exit.log'), 'a')
      if log then
        log:write(os.date '%Y-%m-%d %H:%M:%S ' .. err .. '\n')
        log:close()
      end
    end,
  })

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
      'luapad',
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
      if currentWinBar.bg and currentWinBar.fg then -- if need: !vim.tbl_contains(vim.tbl_keys(currentWinBar),'bg')
        if currentWinBar.bg == badWinBar.bg and currentWinBar.fg == badWinBar.fg then
          vim.api.nvim_set_hl(0, 'WinBar', { bg = 'bg', fg = 'fg' })
          --local normal = vim.api.nvim_get_hl(0, { name = 'Normal' })
          vim.cmd "highlight WinBar guibg='bg' guifg='fg' gui='italic'"
          vim.cmd "highlight WinBarNC guibg='bg'"
        end
      end
      if vim.g.colors_name == 'moonbow' then
        vim.api.nvim_set_hl(0, 'SignColumn', { bg = 'bg' })

        vim.cmd "highlight SignColumn guibg='bg' guifg='fg'"
      end

      --* taking the opportunity to spruce things up -> badWinBar
      --TODO: implement unfocused buffer color dim/fade
      --[[ if normal==normNC then

      end ]]
    end,
  })
  --TODO: Recolor minibar when recording
  --- pattern = filename|reg_recording() = current register in use|auto ('RecordingEnter')

  vim.api.nvim_create_autocmd({ 'BufEnter' }, {
    group = make_augroup 'referencer_refresh',
    pattern = { '*.go' },
    callback = function()
      local ok, ref = pcall(require, 'referencer')
      if ok and ref.enable then
        ref.update()
      end
    end,
  })
end

--- Change options for specific autocommands
--- TODO: unimplemented. The previous body was `vim.tbl_deep_extend 'force'`,
--- which throws (missing args) if this is ever called.
---@param options any
function M.setoptions(options) end

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
