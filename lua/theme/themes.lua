local Maker = {}
--[[
      reference theme names/repo info
      sainnhe/everforest
      everviolet/nvim, name = 'evergarden'
      edeneast/nighhtfox.vim
      alexvzyl/nordic.nvim
      folke/tokyonight
  --]]
local themelist = {
  --{ 'tjdevries/colorbuddy.nvim' },
  { 'mhartington/oceanic-next' }, --+ good all-round blue toward green theme
  { 'Donearm/Ubaryd' }, --+ good brown. Gutter highlight semi-issue, really is fine.
  { 'vext01/theunixzoo-vim-colorscheme' }, --~ good alternate brown-green theme. Tab highlight issue
  { 'vim-scripts/ego.vim' }, --~ loud, tab highlight issue but not as bad. more contrast than others
  { 'fynnfluegge/monet.nvim' }, --+ good theme blue toward purp, good cohesion
  { 'jsit/toast.vim' }, --+ the best blue toward green theme so far. darker than solar
  { 'Nequo/vim-allomancer' }, --~ decent neutral theme, color cohesion isn't ideal, pink/purp sticks out
  { 'marcelbeumer/spacedust.vim' }, --~ love it, besides tab highlight issue
  { 'PHSix/nvim-hybrid' }, --~ its fine, doesnt pop out at me
  { 'FrenzyExists/aquarium-vim' }, --~ tabspace highlight issue. besides that, nice slightly cool
  { 'kvrohit/rasmus.nvim' }, --~ dark, okay color cohesion. kind of nicer vscode, no sure abt
  { 'ribru17/bamboo.nvim' }, --+nice greenish slightly warm, good color cohesion
  { 'cryptomilk/nightcity.nvim' }, --+good color cohesion, washed-out grub with some blues. weird string highlighting
  { 'HoNamDuong/hybrid.nvim' }, --=it's fine. neutral pushing warm. have two of these for some reason
  { 'lalitmee/cobalt2.nvim' }, -- it was working before. try again
  { 'Tsuzat/NeoSolarized.nvim' }, --- no bg - could fix w config if I want to.
  { 'cseelus/vim-colors-lanai' }, --~ poppy pastels, decent cohesion, best of more contrast themes sofar
  { 'rafalbromirski/vim-aurora' }, --+ it works. oh the whichkey bg is pure black tho, weird
  { 'EdenEast/Revolution.vim' }, --+ great
  { 'DemonCloud/J' }, --? dunno where this one is
  { 'franbach/miramare' }, --+ kinda ristrotto
  { 'jedireza/vim-rizzle' }, --~ the rizzler. similar to toast, compare the two. blue-neut
  { 'bluz71/vim-nightfly-colors' }, --- blue, with some orange-yellows, darker, it's nice
  { 'tyrannicaltoucan/vim-quantum' }, --+ lighter dark theme, tends slightly blue toward green, it's good
  { 'Everblush/everblush.vim' }, --+ darker more neutral evergarden (kind of). only issue is red tab marks
  { 'sainnhe/everforest', name = 'everforest', priority = 1000 }, -- theme; mid-dark, green

  -->oh-lucy: darkblue-steel bg, white, light-pink, cool yellow, touch of aqua/teal
  { 'yazeed1s/oh-lucy.nvim', name = 'oh-lucy' }, --+
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
      theme = { variant = 'fall', accent = 'purple' },
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
    config = function() --necessary?
      require('nordic').load {}
    end,
  },
  {
    'xero/miasma.nvim', -- deep jungley
    lazy = false,
    priority = 1000,
  },
  {
    'folke/tokyonight.nvim', -- real blue toward purp, a classic
    priority = 1000,
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('tokyonight').setup {
        styles = { comments = { italic = false } }, -- Disable italics in comments
      }
    end,
  },
}
local themesPineapple = {
  oxocarbon = { 'nyoom-engineering/oxocarbon.nvim', enabled = false },
  lucario = { 'raphamorim/lucario', enabled = false }, --+ great cobalt-ish
  zephyr = { 'nvimdev/zephyr-nvim', enabled = false }, --+ I like it. warm-bearish
  anderson = { 'tlhr/anderson.vim', enabled = false }, --- warm but a bit too flat
  sierra = { 'AlessandroYorba/Sierra', enabled = false }, -- very muted lighter mint green-peach
  oceanic = { 'nvimdev/oceanic-material', enabled = false },
  tender = { 'jacoborus/tender.vim', enabled = false }, -- borderless. interesting, slight warm w/blue
  tundra = { 'sam4llis/nvim-tundra', enabled = false },
  kanagawa = { 'rebelot/kanagawa.nvim', enabled = false },
  witch = { 'sontungexpt/witch', enabled = false },
  bogster = { 'vv9k/bogster', enabled = false }, --pops/contrast, blue toward slight green. it's good!
  bluewery = { 'relastle/bluewery.vim', enabled = false },
  ghostbuster = { 'MvanDiemen/ghostbuster', enabled = false }, -- I can't decide
  typewriter = { 'logico/typewriter', enabled = false },
  plastic = { 'flrnd/plastic.vim', enabled = false },
  darkvoid = { 'darkvoid-theme/darkvoid.nvim', enabled = false },
  hydrangea = { 'yuttie/hydrangea-vim', enabled = false },
}

---@param enabledthemes table | nil list of theme moniker to enable
function Maker.getlist(enabledthemes)
  if enabledthemes then
    for _, v in ipairs(enabledthemes) do
      if themesPineapple[v] then
        themesPineapple[v].enabled = true
      end
    end
  end
  for _, theme in pairs(themesPineapple) do
    table.insert(themelist, theme)
  end
  return themelist
end
return Maker
--[[ Disabling everything I dont need
'savq/melange-nvim' -- nice, warm gruv-ish with more blues and more muted
'bluz71/vim-nightfly-colors'

'theniceboy/nvim-deus',name='deus' decent contrasty vibrant theme, bg: dark gray-blue, text: tan primary
->(gruvy red/yellow with vscode sky-blue and light-green, pink-purplish) not ideal color harmony
--]]
