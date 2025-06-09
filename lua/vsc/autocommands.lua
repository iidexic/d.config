--# Helpers (no want write long)
local auto = vim.api.nvim_create_autocmd
local ag = function(name)
  return vim.api.nvim_create_augroup(name, { clear = true })
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
  -- ── Autocommand-related mapping ───────────────────
  -- toggle hover
  vim.keymap.set('n', 'gh', function()
    M.opts.hover = not M.opts.hover
  end, { desc = 'toggle hover popup' })
  --  ── [0] quick startup auto ──────────────────────────────────────────────
  auto('VimEnter', {
    desc = 'run persistence, would prefer both persistence and whaler',
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
  --  ── [2] resize splits on window resize ───────────────────────────────
  -- (no idea how this works)
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

  -- ── [4] make lsp autocommands on attach ─────────────────────────────────
  auto('LspAttach', {
    group = ag 'lsp-attached-setauto',
    callback = function() --──────────────── LSP ACTIVE ENTERED ───
      -- ───────────────────────── [4a] idle hover popup ───────────────────────
      auto('CursorHold', {
        group = ag 'lsp-hover-custom',
        callback = function()
          if M.opts.hover then -- best way to set this up?
            vim.lsp.buf.hover {
              max_height = 40,
              max_width = 160,
              --offset_x = 4, -- offset defaults probably 0
              --offset_y = 2,
              --zindex = 50, -- default 50, is forward/back. keep here
              anchor_bias = 'auto', --auto|above|below
              relative = 'cursor', --cursor|mouse|editor
              focus = false,
              silent = true,
              --not the biggest fan of border but damn does it make shit easier
              -- "none", "single"(line), "double", "rounded", "solid"(block), "shadow"
              border = 'none', -- borders are being shitty rn

              --close_events = {''} --idk defaults,
            }
          end
        end,
      })
    end,
  })

  auto('LspDetach', {
    group = ag 'lsp-detached-setauto',
    callback = function()
      auto('CursorHold', {
        group = ag 'lsp-hover-custom', -- should clear hover auto
        callback = function() end,
        -- no need to disable hover key really
      })
    end,
  })
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
    },
    callback = function(event)
      vim.bo[event.buf].buflisted = false
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

  -- show signature help on exit insert
  --[[ auto({ 'InsertLeave' }, {
    group = ag 'insert-leave-sighelp',
    callback = function()
      vim.lsp.buf.signature_help { max_width = 86, max_height = 30 }
    end,
  }) ]]
  --TODO: add q to quit for scratch bufs
  --TODO: Recolor minibar when recording
  --- pattern = filename
  --- reg_recording() = current register in use
  -- auto ('RecordingEnter')

  -- ─────┤ Template: changes commands on switching to diff filtype ├─────
  vim.api.nvim_create_autocmd({ 'FileType', 'BufEnter' }, {
    group = vim.api.nvim_create_augroup('filetype_change', { clear = true }),
    pattern = {},
    callback = function(event)
      local ftyp = vim.bo[event.buf].filetype
      --NOTE: COME BACK HERE
      --TODO: FINISH THIS
      --WARNING: I dont remember what I was trying to do
    end,
  })

  -- ─[ AstroNvim Fold Persistence Autocommands ]────────────────────────
  -- astronvim autocommands (old I think) - [ https://github.com/AstroNvim/AstroNvim/blob/271c9c3f71c2e315cb16c31276dec81ddca6a5a6/lua/astronvim/autocmds.lua ]
  --* Using UFO is good with me. Visit the link if want to try with autocommands

  -- ─[ Dirty Debug Auto-Log ]───────────────────────────────────────────
  --[[# Quick Log/Debug: throws out a bunch of info on an event
  -- This setup was for debugging error on exit, prints and also writes to exitlog.txt
    vim.api.nvim_create_autocmd({ 'VimLeave' }, {
    group = vim.api.nvim_create_augroup('on-dirty-exit', { clear = true }),
    callback = function()
      local v = vim.v
      if v.dying then
        local writel = { 'last_except:', v.exception }
        table.insert(writel, 'last_warn:')
        table.insert(writel, vim.v.warningmsg)
        table.insert(writel, 'throwpoint:')
        table.insert(writel, v.throwpoint)
        table.insert(writel, 'trace:')
        unpackadd(writel, v.stacktrace)
        table.insert(writel, 'last_error:' .. v.errmsg)
        table.insert(writel, 'errors:')
        unpackadd(writel, v.errors)
        table.insert(writel, 'shada_old:')
        unpackadd(writel, v.oldfiles)
        --print(unpack(vim.v.stacktrace))
        --print(unpack(vim.v.errors))
        --print(unpack(vim.v.oldfiles))
        --- Single-string details

        vim.fn.writefile(writel, vim.fn.stdpath("config") .. "\\exitlog.txt", 'a')
      end
    end,
  }) --]]

  -- ─[ LazyVim Autocommands ]───────────────────────────────────────────
  --[[
  -- Check if we need to reload the file when it changed
      vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
        group = augroup("checktime"),
        callback = function()
          if vim.o.buftype ~= "nofile" then
            vim.cmd("checktime")
          end
        end,
      })
  -- Getting Lazy Startup and pushing to startuip dash
      vim.api.nvim_create_autocmd("User", {
        once = true,
        pattern = "LazyVimStarted",
        callback = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
    -- replace all this shit til the end of funct with own stuff
          dashboard.section.footer.val = "⚡ Neovim loaded "
            .. stats.loaded
            .. "/"
            .. stats.count
            .. " plugins in "
            .. ms
            .. "ms"
          pcall(vim.cmd.AlphaRedraw)
        end,
--]]
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

return M
