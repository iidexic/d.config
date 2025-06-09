return {
  { -- escape input mode with 'jk'
    'TheBlob42/houdini.nvim', --https://github.com/TheBlob42/houdini.nvim
    config = true,
  },
  --[[ { -- centers the current buffer in window
    -- kind of underwhelming. look at zen mode
    'shortcuts/no-neck-pain.nvim',
    cond = false,
  }, ]]
  { -- makes virtual text at pair close showing context
    -- I prefer this more as a vscode-ish top of screen navbar thing
    -- I know those exist. disabled for now
    'andersevenrud/nvim_context_vt',
    enabled = false,
  },
}
