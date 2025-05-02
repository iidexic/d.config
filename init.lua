--# Pre-Lazy Config
local configure = require 'settings.apply'
configure.prelazy()
configure.theme 'evergarden' --Nordic

--# Autocmd
vim.api.nvim_create_autocmd('TextYankPost', { -- Try it with `yap` in normal mode
  desc = 'Highlight when yanking (copying) text', --See`:help vim.highlight.on_yank()`
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

--# Lazy + Plugins:
require('dlazyinit').LazyPluginSetup()

--# Post-Lazy config
configure.postlazy()

--[[
Other plugins/plugin types to try:
--------------------------------------------
--- autopairs - active now. works good. just gonna keep it
--- Trailblazer (plugins/trailblazer.lua)
----- Marks - alternative to Grapple, It's technically installed right now, but I have not used it.
----- from what I can tell it is similar to grapple's recommended use style
----- marks can be "popped" off the buffer so you are navigating to where you need to go and then jumping back
----- The help docs are not great though. I would need to put some time into it to sort it out
-X- Buffon.nvim 
 ----- I tried buffon. I actually really like it. Problem is that as is it clashes hard with a lot of other 
 ----- key commands, and many of those keys are either not working because buffon isn't done or just
 ----- not working because they are clashing with important builtin commands.
 ----- maybe look at source or just try later.
 ----- For now, I am going to set up Grapple with a bufferline and see if I can make that work similarly

List Currently Installed Plugins

-<    auto-session
-<    cmp-nvim-lsp
-<    cmp-nvim-lsp-signature-help
-<    cmp-path
-<    cmp-under-comparator
-<    cmp_luasnip
-<    conform.nvim
-<    diffview.nvim
-<    fidget.nvim
-<    flatten.nvim
-<    friendly-snippets
-<    gitsigns.nvim
-<    go.nvim
-<    goimpl.nvim
-<    guihua.lua
-<    hot.nvim
-<    lazy.nvim
-<    lazydev.nvim
-<    LuaSnip
-<    mason-lspconfig.nvim
-<    mason-nvim-dap.nvim
-<    mason-tool-installer.nvim
-<    mason.nvim
-<    mini.nvim
-<    neogit
-<    nvim-autopairs
-<    nvim-cmp
-<    nvim-dap  - debug adapter protocol client
-<    nvim-dap-ui
-<    nvim-lspconfig
-<    nvim-treesitter
-<    navigator.lua
-<    nvim-trevJ.lua - (reverse-join)
-<    nvim-web-devicons
-<    plenary.nvim
-<    rainbow-delimiters.nvim
-<    scratch.nvim
-<    vim-sleuth
-<    which-key.nvim
-|    trailblazer.nvim
    === LANGUAGES ===
    == lua ==
-<    nvim-luapad
    == go ==
-<    structrue-go.nvim
    === SCOPE ===
-<    telescope.nvim
-->    grapple.nvim
-->   agrolens.nvim - Not Really Working
-->    whaler.nvim
-->    telescope-fzf-native.nvim
-->    telescope-ui-select.nvim
-->    telescope-zoxide

== comments ==
-<    todo-comments.nvim
-<    comment-box.nvim
-<    Comment.nvim

=== THEMES ===
-<    everforest
-<    evergarden
-<    miasma.nvim
-<    nightfox.nvim
-<    nordic
-<    tokyonight.nvim
-<    oh-lucy

--]]

--===============================================================================
--===============================================================================
--><-><-><-><-><-><-><-><-><-><-><-><-><-><-><-><-><-><-><-><-><-><-><-><-><-><--
--===============================================================================
--===============================================================================
--------------------------------------------------------------------------------
--!NOTE: DO NOT DELETE BELOW
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
