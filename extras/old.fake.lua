--- a not real lua file to store old config sections
--- until I get the git set up

--==========[ Replaced with settings folder and config loader ]===========--
--[[ 
--# Base config
vim.g.mapleader = ' ' -- must happen before plugins are loaded
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true -- make sure nerdfont selected in term
vim.opt.relativenumber = true -- Make line numbers default
vim.opt.number = true
vim.opt.mouse = 'a' -- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.showmode = true -- Don't show the mode, since it's already in the status line
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

--* indent
vim.opt.tabstop = 8 -- sets how nvim actually writes tabs in files. default is 8 (help says not to change?)
vim.opt.softtabstop = 8 -- this sets what tabs appear as in nvim, regardless of file contents
vim.opt.shiftwidth = 8
vim.opt.expandtab = true
vim.opt.breakindent = true -- Enable break indent (basically wraps visually I think??)
--*

vim.opt.undofile = true -- Save undo history
vim.opt.ignorecase = true -- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes' -- Keep signcolumn on by default
vim.opt.updatetime = 250 -- Decrease update time
vim.opt.timeoutlen = 300 -- Decrease mapped sequence wait time
vim.opt.splitbelow = true
vim.opt.splitright = true -- Configure how new splits should be opened
vim.opt.list = true -- Sets how certain whitespace characters display in editor. See `:help 'list'` and `:help 'listchars'`
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' } -- try tab='|-|'?
vim.opt.inccommand = 'split' -- Preview substitutions live, as you type!
vim.opt.cursorline = true -- Show which line your cursor is on
vim.opt.scrolloff = 10 -- Minimal number of screen lines to keep above and below the cursor.

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>') --  See `:help hlsearch`
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
--]]
