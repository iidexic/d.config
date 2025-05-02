return {
  { -- escape input mode with 'jk'
    'TheBlob42/houdini.nvim', --https://github.com/TheBlob42/houdini.nvim
    config = function()
      require('houdini').setup()
    end,
  },
}
