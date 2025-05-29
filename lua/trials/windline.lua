return {
  { -- new statusline with animations. Check github to grab some status lines to plug in here, looks cool
    'windwp/windline.nvim',
    config = function()
      require('windline ').setup {
        statuslines = {
          --- you need to define your status lines here
        },
      }
    end,
  },
}
