local nofunc = function() end
local Maker = {}

Maker.themelist = {
  -- ── Cool Themes ─────────────────────────────────────────────────────
  { -- The best, main theme
    'everviolet/nvim',
    name = 'evergarden',
    priority = 1000,
    opts = { -- variants: 'winter'|'fall'|'spring'|'summer'
      theme = { variant = 'fall', accent = 'red' }, -- cant b purple :)
      editor = {
        transparent_background = false,
        sign = { color = 'none' },
        float = {
          color = 'mantle',
          invert_border = false,
        }, -- more config options on github
        completion = { color = 'surface0' },
      },
    },
  },
  ----| Teal/blue-green |----
  { 'raphamorim/lucario' }, --+ great cobalt-ish
  { 'Tsuzat/NeoSolarized.nvim', opts = { transparent = false }, priority = 1000 },
  { 'mhartington/oceanic-next' }, --+ good all-round blue toward green theme
  { 'jsit/toast.vim' }, --+  blue toward green theme.
  --{ 'PHSix/nvim-hybrid', priority = 1000, lazy = false }, no alt bg
  { 'nvimdev/oceanic-material' }, --+ great

  ----|Blue/Deep|----
  {
    'bluz71/vim-nightfly-colors',
    config = function()
      vim.g.nightflyCursorColor = true
      vim.g.nightflyNormalPmenu = true
      vim.g.nightflyTerminalColors = true
      vim.g.nightflyVirtualTextColor = true
      vim.g.nightflyWinSeparator = 2
      require('nightfly').custom_colors { bg = '#081824' } -- default bg '#011627'
    end,
  }, --- blue, with some orange-yellows, darker, it's nice

  ----| Flatter |----
  { 'fynnfluegge/monet.nvim' }, --+ good theme blue toward purp, good cohesion
  { 'tyrannicaltoucan/vim-quantum' }, --+ lighter dark theme, tends slightly blue toward green, it's good
  {
    'Everblush/nvim',
    name = 'everblush',
    opts = {
      override = {
        Cursor = { fg = '#102e1e', bg = '#EfA0C2' },
      },
      nvim_tree = {
        contrast = true,
      },
    },
  }, --+ NVIM VERSION NOW! darker more neutral evergarden (kind of). only issue is red tab marks
  { 'sainnhe/everforest', name = 'everforest', priority = 1000, enabled = false }, -- theme; mid-dark, green

  -- ── Near Neutrals ───────────────────────────────────────────────────
  { 'rebelot/kanagawa.nvim' }, -- has blue ish flat wave theme, darker jungley dragon theme
  { 'cryptomilk/nightcity.nvim' }, --+good color cohesion, washed-out grub with some blues. weird string highlighting
  --{ 'HoNamDuong/hybrid.nvim', priority = 1000, opts = { transparent = false, inverse = false } }, --=it's fine. neutral pushing warm. have two of these for some reason
  { 'rafalbromirski/vim-aurora' }, --+ Darker Neutral, colorful. has some black bgs
  { 'EdenEast/Revolution.vim' }, --+ great. Definitely slightly green/yellow
  { 'flrnd/plastic.vim' }, -- neutral with muted blue/orange/green
  { 'sam4llis/nvim-tundra' }, -- certainly blue, but feels more neutral with all the reds
  { -- pushes warm
    'chama-chomo/grail', --~ replace in material!
    version = false,
    lazy = false,
    priority = 1000, -- make sure to load this before all the other start plugins
    opts = {},
  },
  {
    'EdenEast/nightfox.nvim',
    names = { 'nightfox', 'nordfox', 'terafox', 'carbonfox', 'duskfox', 'dawnfox', 'dayfox' },
    opts = {}, -- should trigger require('nightfox').setup({ })
  },

  -- ── Warm Themes ─────────────────────────────────────────────────────
  ----|Jungle|----
  { 'ribru17/bamboo.nvim' }, --~nice greenish slightly warm, good color cohesion

  ----|Rose|----
  { 'franbach/miramare' }, --++ kinda ristrotto

  ----|Brown|----
  { 'Donearm/Ubaryd', cond = true }, --+ light brown
  { 'nvimdev/zephyr-nvim', priority = 1000 }, --+ neutral to warm

  { 'vv9k/bogster' }, --+ best theme
  { 'relastle/bluewery.vim' },
  { 'darkvoid-theme/darkvoid.nvim' }, -- good mono theme with green operators
  { 'yuttie/hydrangea-vim' }, -- eh. strings are highlighted blue for some reason
  { 'yazeed1s/oh-lucy.nvim', name = 'oh-lucy' }, -- darkblue-steel bg, white, light-pink, cool yellow, touch of aqua/teal
  { 'jacoborus/tender.vim' }, -- borderless. interesting, slight warm w/blue

  { --> Great, nordic with some reds added, works well
    'AlexvZyl/nordic.nvim',
    name = 'nordic',
    lazy = false,
    priority = 1000,
  },
  {
    'xero/miasma.nvim', -- deep jungley
    lazy = false,
    priority = 1000,
  },
  { 'tiagovla/tokyodark.nvim', opts = {} }, -- I think going to replace tokyonight
  {
    'folke/tokyonight.nvim', --  a classic
    priority = 1000,
  },
}
-- ── Maybe Try Again ─────────────────────────────────────────────────
-- { 'Yagua/nebulous.nvim', enabled = true, priority = 1000, opts = { variant = 'nova' } }, -- dont work without some config shit.

-- ╭─────────────────────────────────────────────────────────╮
-- │                    REMOVED/DISABLED                     │
-- ╰─────────────────────────────────────────────────────────╯
--{ 'datsfilipe/min-theme.nvim' }, -- I just don't like it
--{ 'https://gitlab.com/aaec/workingg1rl' }, -- not work, stole colors for material
--{ 'neko-night/nvim', lazy = false, priority = 1000, opts = {} }, -- big pack
--{ 'kwsp/halcyon-neovim', enabled = true }, -- has no bg color (), bad
--{ 'cdmill/neomodern.nvim', lazy = false, priority = 1000, opts = {}, put this back if fails/errors: config = function() require('neomodern').setup {} require('neomodern').load() end, },
-- { 'talha-akram/noctis.nvim',enabled = false }, --pack
-- { 'forest-nvim/sequoia.nvim', priority = 1000, enabled = false }, -- man all 3 styles are like close but not into it
-- { 'cocopon/iceberg.vim', enabled = false }, -- whatever mono
-- { 'luisiacc/gruvbox-baby', enabled = false }, -- not gruv enough
-- { 'ronisbr/nano-theme.nvim', enabled = false }, -- Very minimal, have enough. add vim.o.background = 'dark' if this errors
-- { 'oonamo/ef-themes.nvim', cond = false }, -- big ass pack. not worth wading thru
-- ef keepers:
-- dream
-- tint ?
-- false
-- bio
-- maris-dark
-- tritanopia-dark
-- ── removed ────────────────────────────────
--{ 'Nequo/vim-allomancer', cond = false }, --~ decent neutral theme, color cohesion isn't ideal, pink/purp sticks out
--{ 'FrenzyExists/aquarium-vim', cond = false }, --~ tabspace highlight issue. besides that, nice slightly cool
--{ 'vext01/theunixzoo-vim-colorscheme', cond = false }, --~ too many issues with black shit
--{ 'marcelbeumer/spacedust.vim', enabled = false }, --~ love it, besides tab highlight issue
-- { 'nyoom-engineering/oxocarbon.nvim', enabled = false }, -- too much
-- { 'AlessandroYorba/Sierra', enabled = false }, -- very muted lighter mint green-peach
-- { 'logico/typewriter', enabled = false }, -- will never use
--{ 'tjdevries/colorbuddy.nvim' }, -- try out again?
--{ 'lalitmee/cobalt2.nvim', config = true, priority = 1000 }, -- needs colorbuddy
-- { 'DemonCloud/J', opts = {} }, -- old vim one that you have to manually move??? wtf

return Maker
