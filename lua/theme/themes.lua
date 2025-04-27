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

function Maker.getlist()
  return themelist
end
return Maker
--[[ Disabling everything I dont need
'savq/melange-nvim' -- nice, warm gruv-ish with more blues and more muted
'bluz71/vim-nightfly-colors'

'theniceboy/nvim-deus',name='deus' decent contrasty vibrant theme, bg: dark gray-blue, text: tan primary
->(gruvy red/yellow with vscode sky-blue and light-green, pink-purplish) not ideal color harmony
--]]
