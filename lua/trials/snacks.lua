return {

  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    cond = false,
    ---@type snacks.Config
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      bigfile = { enabled = true },
      dashboard = { enabled = true },
      explorer = { enabled = true },
      indent = { enabled = true },
      input = { enabled = true },
      picker = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      scope = { enabled = true },
      --scroll = { enabled = false },
      --statuscolumn = { enabled = true },
      words = { enabled = true },
    },
  },
}
--[[
╭─────────────────────────────────────────────────────────╮
│                 Plugins Snacks Replaces                 │
╰─────────────────────────────────────────────────────────╯
--> (Definitely Replace:)
-> bufdelete + close-buffers
-> scratch.nvim
-> lazygit
-> indent-blankline.nvim

--? (Maybe Replace:)
-? git plugins (tinygit, neogit)
-? notifier (fidget.nvim) - currently a dependency of nvim-lspconfig
-? rename (file rename?) - also, file explore (neotree/mini.files)
-? terminal (toggleterm/maybe flatten)

--| (Uncertain/New feature:)
-| picker-> prob still want telescope
-| statuscolumn (do I have one? is this gutter?)
-| words: auto show lsp refs = one of lsp plugins? (lspsaga)
--]]

--[[
Snack        - DescriptionSetup
animate      - Efficient animations including over 45 easing functions (library)
bigfile      - Deal with big files‼️
bufdelete    - Delete buffers without disrupting window layout
dashboard    - Beautiful declarative dashboards‼️
debug        - Pretty inspect & backtraces for debugging
dim          - Focus on the active scope by dimming the rest
explorer     - A file explorer (picker in disguise)‼️
git          - Git utilities
gitbrowse    - Open the current file, branch, commit, or repo in a browser (e.g. GitHub, GitLab, Bitbucket)
image        - Image viewer using Kitty Graphics Protocol, supported by kitty, wezterm and ghostty‼️
indent       - Indent guides and scopes
input        - Better vim.ui.input‼️
layout       - Window layouts
lazygit      - Open LazyGit in a float, auto-configure colorscheme and integration with Neovim
notifier     - Pretty vim.notify‼️
notify       - Utility functions to work with Neovim's vim.notify
picker       - Picker for selecting items‼️
profiler     - Neovim lua profiler
quickfile    - When doing nvim somefile.txt, it will render the file as quickly as possible, before loading your plugins.‼️
rename       - LSP-integrated file renaming with support for plugins like neo-tree.nvim and mini.files.
scope        - Scope detection, text objects and jumping based on treesitter or indent‼️
scratch      - Scratch buffers with a persistent file
scroll       - Smooth scrolling‼️
statuscolumn - Pretty status column‼️
terminal     - Create and toggle floating/split terminals
toggle       - Toggle keymaps integrated with which-key icons / colors
util         - Utility functions for Snacks (library)
win          - Create and manage floating windows or splits
words        - Auto-show LSP references and quickly navigate between them‼️
zen          - Zen mode • distraction-free coding
--]]
