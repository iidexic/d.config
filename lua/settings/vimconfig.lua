local O = {
  first = function()
    --# Base config
    vim.g.mapleader = ' ' -- must happen before plugins are loaded
    vim.g.maplocalleader = ' '
    vim.g.have_nerd_font = true -- make sure nerdfont selected in term
    vim.opt.relativenumber = true -- Make line numbers default
    vim.opt.number = true
    vim.opt.mouse = 'a' -- Enable mouse mode, can be useful for resizing splits for example!
    vim.opt.showmode = false -- Don't show the mode, since it's already in the status line
    vim.schedule(function()
      vim.opt.clipboard = 'unnamedplus'
    end)

    vim.opt.undofile = true -- Save undo history
    vim.opt.ignorecase = true -- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
    vim.opt.smartcase = true
    vim.opt.signcolumn = 'yes' -- Keep signcolumn on by default
    vim.opt.updatetime = 450 -- Decrease update time (and then increase a bit from the decrease)
    vim.opt.timeoutlen = 300 -- Decrease mapped sequence wait time
    vim.opt.splitbelow = true
    vim.opt.splitright = true -- Configure how new splits should be opened
    vim.opt.list = true -- Sets how certain whitespace characters display in editor. See `:help 'list'` and `:help 'listchars'`
    vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' } -- try tab='|-|'?
    vim.opt.inccommand = 'split' -- Preview substitutions live, as you type!
    vim.opt.cursorline = true -- Show which line your cursor is on
    vim.opt.scrolloff = 16 -- Minimal number of screen lines to keep above and below the cursor.

    ---* additional settings *---
    vim.opt.termguicolors = true
    vim.opt.pumheight = 16
    --* indent/tab
    vim.opt.tabstop = 8 -- sets how nvim actually writes tabs in files. default is 8 (help says not to change?)
    vim.opt.softtabstop = 3 -- this sets what tabs appear as in nvim, regardless of file contents
    vim.opt.shiftwidth = 3
    vim.opt.expandtab = true
    vim.opt.breakindent = true -- Enable break indent (basically wraps visually I think??)
    ---*
    ---* Window opts *---
    --- going to do this twice as it seems it does not work here
    vim.o.winminwidth = 10
    vim.o.winwidth = 120
    vim.o.winheight = 70
    vim.o.equalalways = false
    vim.o.splitkeep = 'screen'

    ---* other potentially useful *---
    --vim.o.confirm = true --> instead of error on :q will ask if want to save
    --* Match-Pairs *--
  end,
  ---@param opts table | nil
  last = function(opts)
    if opts and opts.sessionoptions then
      -- Is this from kickstart?
      vim.o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'
      print(vim.o.sessionoptions)
    end
    ---* Lazygit Options *---
    vim.g.lazygit_floating_window_use_plenary = 1
    vim.g.lazygit_floating_window_scaling_factor = 0.7
    ---*2nd try*---
    vim.o.winminwidth = 10
    vim.o.winwidth = 120
    vim.o.winheight = 50
    vim.o.winminheight = 8
    vim.o.equalalways = false
    vim.o.splitkeep = 'topline'
  end,
}

return O
