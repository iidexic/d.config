return {
  { -- probably remove
    'smjonas/live-command.nvim',
    -- live-command supports semantic versioning via Git tags
    -- tag = "2.*",
    config = true,
    cond = false,
  },

  { -- Removing. way too much to learn for folds that look slightly nicer. Using UFO
    'OXY2DEV/foldtext.nvim',
    lazy = false,
    cond = false, --  this is too much
    -- For opts: everything is made up of 'parts'
    -- default parts:
    -- bufline (treesitter highlighted), description (conventional fold description)
    opts = {
      -- ignore_buftypes, ignore_filetypes
      -- condition function (true=enabled for that buf/win)
      styles = {
        --[[ default = {
          parts = {
            { kind = 'bufline' },
            -- who knows if this is how it works:
            -- edit: doesn't seem like it
            --{ kind = 'description' },
          },
        }, ]]
        dfold = { -- Custom foldtext.
          filetypes = { 'go', 'lua', 'zig' }, -- Only on these filetypes.
          buftypes = {}, -- Only on these buftypes.

          -- Only if this condition is
          -- true.
          condition = function(win)
            return vim.wo[win].foldmethod == 'manual'
          end,

          -- Parts to create the foldtext.
          parts = {
            { kind = 'bufline' },
            { kind = 'fold_size' },
            { kind = 'description' },
          },
        },
      },
    },
  },
}
