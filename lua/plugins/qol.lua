return {
  {
    'smjonas/live-command.nvim',
    -- live-command supports semantic versioning via Git tags
    -- tag = "2.*",
    config = true,
    cond = false,
  },
  { -- centers the current buffer in window
    --? any issue with current window width/height opts?
    'shortcuts/no-neck-pain.nvim',
    cond = true,
  },
  { -- makes virtual text at pair close showing context
    -- I prefer this more as a vscode-ish top of screen navbar thing
    -- I know those exist. disabled for now
    'andersevenrud/nvim_context_vt',
    enabled = false,
  },
  { -- makes folds look nicer. its fine, check later
    'OXY2DEV/foldtext.nvim',
    lazy = false,
    enabled = true,
  },
}
