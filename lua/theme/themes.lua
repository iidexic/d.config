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
  --[[ { 'vim-scripts/ego.vim' }, --~ loud, tab highlight issue but not as bad. more contrast than others
  { 'kvrohit/rasmus.nvim' }, --~ dark, okay color cohesion. kind of nicer vscode, no sure abt
  { 'cseelus/vim-colors-lanai' }, --~ poppy pastels, decent cohesion, best of more contrast themes sofar
  { 'jedireza/vim-rizzle', cond = false }, --~ the rizzler. similar to toast, compare the two. blue-neut ]]

Maker.themelist = {
  --{ 'tjdevries/colorbuddy.nvim' }, -- try out again?
  { 'mhartington/oceanic-next' }, --+ good all-round blue toward green theme
  { 'Donearm/Ubaryd', cond = false }, --+ good brown. Gutter highlight semi-issue, really is fine.
  { 'vext01/theunixzoo-vim-colorscheme', cond = false }, --~ good alternate brown-green theme. Tab highlight issue

  { 'fynnfluegge/monet.nvim' }, --+ good theme blue toward purp, good cohesion
  { 'jsit/toast.vim' }, --+ the best blue toward green theme so far. darker than solar
  { 'Nequo/vim-allomancer', cond = false }, --~ decent neutral theme, color cohesion isn't ideal, pink/purp sticks out
  { 'marcelbeumer/spacedust.vim' }, --~ love it, besides tab highlight issue
  { 'PHSix/nvim-hybrid' }, --~ its fine, doesnt pop out at me
  { 'FrenzyExists/aquarium-vim', cond = false }, --~ tabspace highlight issue. besides that, nice slightly cool
  { 'ribru17/bamboo.nvim' }, --+nice greenish slightly warm, good color cohesion
  { 'cryptomilk/nightcity.nvim' }, --+good color cohesion, washed-out grub with some blues. weird string highlighting
  { 'raphamorim/lucario' }, --+ great cobalt-ish
  { 'HoNamDuong/hybrid.nvim', config = true }, --=it's fine. neutral pushing warm. have two of these for some reason
  --{ 'lalitmee/cobalt2.nvim', config = true, priority = 1000 }, -- needs colorbuddy
  { 'Tsuzat/NeoSolarized.nvim', opts = { transparent = false }, priority = 1000 }, --- no bg - could fix w config if I want to.
  { 'rafalbromirski/vim-aurora' }, --+ it works. oh the whichkey bg is pure black tho, weird
  { 'EdenEast/Revolution.vim' }, --+ great
  { 'DemonCloud/J' }, --? dunno where this one is
  { 'franbach/miramare' }, --+ kinda ristrotto
  { 'bluz71/vim-nightfly-colors' }, --- blue, with some orange-yellows, darker, it's nice
  { 'tyrannicaltoucan/vim-quantum' }, --+ lighter dark theme, tends slightly blue toward green, it's good
  { 'Everblush/everblush.vim' }, --+ darker more neutral evergarden (kind of). only issue is red tab marks
  { 'sainnhe/everforest', name = 'everforest', priority = 1000 }, -- theme; mid-dark, green

  { 'nvimdev/zephyr-nvim' }, --+ I like it. warm-bearish
  { 'AlessandroYorba/Sierra' }, -- very muted lighter mint green-peach
  { 'nvimdev/oceanic-material' },
  { 'sam4llis/nvim-tundra' },
  { 'nyoom-engineering/oxocarbon.nvim' },
  { 'rebelot/kanagawa.nvim' },
  { 'vv9k/bogster' }, --pops/contrast, blue toward slight green. it's good!
  { 'relastle/bluewery.vim' },
  { 'MvanDiemen/ghostbuster', cond = false }, -- I can't decide
  { 'logico/typewriter' },
  { 'flrnd/plastic.vim' },
  { 'darkvoid-theme/darkvoid.nvim' },
  { 'yuttie/hydrangea-vim' },
  -->oh-lucy: darkblue-steel bg, white, light-pink, cool yellow, touch of aqua/teal
  { 'yazeed1s/oh-lucy.nvim', name = 'oh-lucy' }, --+
  { 'jacoborus/tender.vim' }, -- borderless. interesting, slight warm w/blue
  {
    'chama-chomo/grail', --~ it's alright, neutral-warmish bg with mixed but cohesive palette
    version = false,
    lazy = false,
    priority = 1000, -- make sure to load this before all the other start plugins
    -- Optional; default configuration will be used if setup isn't called.
    opts = {},
  },
  {
    'everviolet/nvim', -- really good! evergreen with some reds
    name = 'evergarden',
    priority = 1000, -- Colorscheme plugin is loaded first before any other plugins
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
  {
    -- "nightfox" (cobalt-ish), "nordfox"(kinda nordic but not as clean)
    -- "terafox"(greeny, is nice), "carbonfox"(neutral), "duskfox"(purple)
    'EdenEast/nightfox.nvim',
    names = { 'nightfox', 'nordfox', 'terafox', 'carbonfox', 'duskfox', 'dawnfox', 'dayfox' },
    opts = {}, -- should trigger require('nightfox').setup({ })
  },
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
