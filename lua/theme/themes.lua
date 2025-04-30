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
  { 'sainnhe/everforest', name = 'everforest', priority = 1000 }, -- theme; mid-dark, green

  -->oh-lucy: darkblue-steel bg, white, light-pink, cool yellow, touch of aqua/teal
  { 'yazeed1s/oh-lucy.nvim', name = 'oh-lucy' },
  {
    'everviolet/nvim', -- really good! evergreen with some reds
    name = 'evergarden',
    priority = 1000, -- Colorscheme plugin is loaded first before any other plugins
    opts = { -- variants: 'winter'|'fall'|'spring'|'summer'
      theme = { variant = 'spring', accent = 'red' },
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
    'folke/tokyonight.nvim',
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
  srcery = { 'srcery-colors/srcery-vim', enabled = false },
  lucario = { 'raphamorim/lucario', enabled = false },
  zephyr = { 'nvimdev/zephyr-nvim', enabled = false },
  anderson = { 'tlhr/anderson.vim', enabled = false },
  Sierra = { 'AlessandroYorba/Sierra', enabled = false },
  everblush = { 'Everblush/everblush.vim', enabled = false },
  oceanic = { 'nvimdev/oceanic-material', enabled = false },
  miramare = { 'franbach/miramare', enabled = false },
  toast = { 'jsit/toast.vim', enabled = false },
  tender = { 'jacoborus/tender.vim', enabled = false },
  tundra = { 'sam4llis/nvim-tundra', enabled = false },
  kanagawa = { 'rebelot/kanagawa.nvim', enabled = false },
  witch = { 'sontungexpt/witch', enabled = false },
  quantum = { 'tyrannicaltoucan/vim-quantum', enabled = false },
  monet = { 'fynnfluegge/monet.nvim', enabled = false },
  bogster = { 'vv9k/bogster', enabled = false },
  bluewery = { 'relastle/bluewery.vim', enabled = false },
  ghostbuster = { 'MvanDiemen/ghostbuster', enabled = false },
  typewriter = { 'logico/typewriter', enabled = false },
  vesper = { 'datsfilipe/vesper.nvim', enabled = false },
  allomancer = { 'Nequo/vim-allomancer', enabled = false },
  plastic = { 'flrnd/plastic.vim', enabled = false },
  flatlandia = { 'jordwalke/flatlandia', enabled = false },
  wal = { 'dylanaraps/wal.vim', enabled = false },
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
