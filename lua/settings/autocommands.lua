--# Helpers (no want write long)
local auto = vim.api.nvim_create_autocmd
local agnames = {}
local make_augroup = require('settings.vim_util').autogroup
-- local make_augroup = function(name) table.insert(agnames, name); return vim.api.nvim_create_augroup(name, { clear = true }) end

-- NOTE: lsp autocommands are in autocommands_lsp.lua
-- NOTE: autocommands to control/change hover provider (and corresponding settings) have been removed

local M = {}
local fp = require 'util.filepath'

-- make autocommand for persistence save to close neotree
-- NOTE: neotree not currently in use
local function persistAuto()
  auto('User', {
    pattern = 'PersistenceSavePre',
    desc = 'eliminate unwanted buffers before saving',
    group = make_augroup 'pre-save-buffer-elimination',
    callback = function()
      require('no-neck-pain').disable()
      require('outline').close()
      require('aerial').close()
    end,
  })
end

--  ┌─────────────────────────[ MAKE AUTOCOMMANDS ]─────────────────────────┐
local function autocmd()
  -- ── Autocommand-related mapping ───────────────────
  -- NOTE: hover autocommands removed
  --  ── [0] quick startup auto ──────────────────────────────────────────────
  auto('VimEnter', {
    desc = 'run whaler on startup if not in file',
    group = make_augroup 'startup-greet',
    callback = function()
      --require('persistence').select()
      if vim.bo.filetype == '' then
        require('telescope').extensions.whaler.whaler()
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

  -- ── [3] delete tmp shada on shada lockup ────────────────────────────────
  auto({ 'VimLeave' }, {
    group = make_augroup 'on-dirty-exit',
    callback = function()
      if vim.v.dying then
        if string.sub(vim.v.errmsg, 1, 4) == 'E138' then
          local shdir = vim.fn.stdpath 'data' .. '\\shada'
          local shadas = vim.fn.globpath(shdir, '*.tmp.*', false, true)
          for _, v in pairs(shadas) do -- deletes all shada tmp files
            vim.fn.delete(v)
          end
        else
          -- write to log file
          local logfile = vim.fn.stdpath 'data' .. '\\logs\\nvim-dirty-exit.log'

          local log = io.open(logfile, 'a')
          if log then
            log:write(vim.v.errmsg .. '\n')
            log:close()
          end
        end
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
      '*\\*_luapad.lua',
      'diffview',
      'gitsigns://',
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

  vim.api.nvim_create_autocmd({ 'BufEnter' }, { -- , 'FileType'
    group = make_augroup 'referencer_refresh',
    pattern = { '*.go' },
    callback = function(event)
      local ref = require 'referencer'
      if ref.enable then
        ref.update()
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
