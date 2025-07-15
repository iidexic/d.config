local nofunc = function() end
local Maker = {}
--[[ 
 ── Problems: ───────────────────────────────────────────────────────
 Themes that have black trouble quickfix window / other black:
   * OceanicNext - great; trouble quickfix + hover is black but not neotree/others
   * Revolution - black trouble. hover is partially black?
   * darkvoid - trouble
   * Lucario - but everything else is great, it's just trouble + hover
   * miramare but it looks good
   * plastic, oxocarbon, sierra, toast
   * Spacedust is kinda rough
- hydrangea is kinda weird, highlights strings in deep blue
** bluewery-light and bluewery-text-writing:
    -> light themes; if loaded, other themes won't be able to change to dark 
-- ── removed ────────────────────────────────
  --{ 'Nequo/vim-allomancer', cond = false }, --~ decent neutral theme, color cohesion isn't ideal, pink/purp sticks out
  --{ 'FrenzyExists/aquarium-vim', cond = false }, --~ tabspace highlight issue. besides that, nice slightly cool
  --{ 'vext01/theunixzoo-vim-colorscheme', cond = false }, --~ too many issues with black shit
 --]]

Maker.themelist = {
  --{ 'tjdevries/colorbuddy.nvim' }, -- try out again?
  --{ 'lalitmee/cobalt2.nvim', config = true, priority = 1000 }, -- needs colorbuddy
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
  { 'Tsuzat/NeoSolarized.nvim', opts = { transparent = false }, priority = 1000 }, --- no bg - could fix w config if I want to.
  { 'mhartington/oceanic-next' }, --+ good all-round blue toward green theme
  { 'jsit/toast.vim' }, --+ the best blue toward green theme so far. darker than solar
  { 'PHSix/nvim-hybrid' }, --~ its fine, doesnt pop out at me
  { 'nvimdev/oceanic-material' }, --+ great

  ----| Green |----
  { 'marcelbeumer/spacedust.vim' }, --~ love it, besides tab highlight issue

  ----|Blue/Deep|----
  { 'bluz71/vim-nightfly-colors' }, --- blue, with some orange-yellows, darker, it's nice

  ----| Flatter |----
  { 'fynnfluegge/monet.nvim' }, --+ good theme blue toward purp, good cohesion
  { 'tyrannicaltoucan/vim-quantum' }, --+ lighter dark theme, tends slightly blue toward green, it's good

  { 'Everblush/nvim', name = 'everblush' }, --+ NVIM VERSION NOW! darker more neutral evergarden (kind of). only issue is red tab marks
  { 'sainnhe/everforest', name = 'everforest', priority = 1000 }, -- theme; mid-dark, green

  -- ── Near Neutrals ───────────────────────────────────────────────────
  { 'rebelot/kanagawa.nvim' }, -- has blue ish flat wave theme, darker jungley dragon theme
  { 'nyoom-engineering/oxocarbon.nvim' }, -- neutral darker background with vibrant blue/purple/pink for rest of colors
  { 'cryptomilk/nightcity.nvim' }, --+good color cohesion, washed-out grub with some blues. weird string highlighting
  { 'HoNamDuong/hybrid.nvim', config = true, priority = 1000 }, --=it's fine. neutral pushing warm. have two of these for some reason
  { 'rafalbromirski/vim-aurora' }, --+ Darker Neutral, colorful. has some black bgs
  { 'EdenEast/Revolution.vim' }, --+ great. Definitely slightly green/yellow
  { 'flrnd/plastic.vim' }, -- neutral with muted blue/orange/green
  { 'sam4llis/nvim-tundra' }, -- certainly blue, but feels more neutral with all the reds
  { -- pushes warm
    'chama-chomo/grail', --~ it's alright, neutral-warmish bg with mixed but cohesive palette
    version = false,
    lazy = false,
    priority = 1000, -- make sure to load this before all the other start plugins
    opts = {},
  },
  {
    -- "nightfox" (cobalt-ish), "nordfox"(kinda nordic but not as clean)
    -- "terafox"(greeny, is nice), "carbonfox"(neutral), "duskfox"(purple)
    'EdenEast/nightfox.nvim',
    names = { 'nightfox', 'nordfox', 'terafox', 'carbonfox', 'duskfox', 'dawnfox', 'dayfox' },
    opts = {}, -- should trigger require('nightfox').setup({ })
  },

  -- ── Warm Themes ─────────────────────────────────────────────────────
  ----|Jungle|----
  { 'ribru17/bamboo.nvim' }, --+nice greenish slightly warm, good color cohesion

  ----|Rose|----
  { 'franbach/miramare' }, --+ kinda ristrotto
  { 'AlessandroYorba/Sierra' }, -- very muted lighter mint green-peach

  ----|Brown|----
  { 'Donearm/Ubaryd', cond = true }, --+ good brown. Gutter highlight semi-issue, really is fine.
  { 'nvimdev/zephyr-nvim', priority = 1000 }, --+ I like it. warm-bearish

  { 'DemonCloud/J' }, --? dunno where this one is

  { 'vv9k/bogster' }, --pops/contrast, blue toward slight green. it's good!
  { 'relastle/bluewery.vim' },
  { 'MvanDiemen/ghostbuster', cond = false }, -- I can't decide
  { 'logico/typewriter' },
  { 'darkvoid-theme/darkvoid.nvim' },
  { 'yuttie/hydrangea-vim' },
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
  {
    'folke/tokyonight.nvim', -- real blue toward purp, a classic
    priority = 1000,
  },
}

return Maker
