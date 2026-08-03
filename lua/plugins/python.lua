return {
  {
    'benlubas/molten-nvim',
    version = '^1.0.0', -- use version <2.0.0 to avoid breaking changes
    -- NOTE: removed `build = ':UpdateRemotePlugins'`. It blocks nvim on Lazy
    -- update when the python remote-plugin host isn't set up. Run manually:
    -- `:UpdateRemotePlugins` (requires `pip install pynvim`).
    cmd = { 'MoltenInit', 'MoltenEvaluateOperator', 'MoltenEvaluateLine', 'MoltenEvaluateVisual', 'MoltenReevaluateCell' },
    init = function()
      -- vim.g.molten_output_win_max_height = 12
    end,
  },
}
