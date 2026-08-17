return {
  -- ╭────────────────────────────── KEEPING ──────────────────────────────╮
  {
    'samharju/serene.nvim',
  },
  {
    'katawful/kat.nvim', --[[ tag = 3.1 ]]
  },
  { 'mrjones2014/lighthaus.nvim' },
  {
    'stevedylandev/darkmatter-nvim',
    lazy = false,
    priority = 1000,
  },
  {
    'adibhanna/forest-night.nvim',
    priority = 1000,
  },
  { 'metalelf0/jellybeans-nvim' },
  { 'uhs-robert/oasis.nvim' },
  { 'sainnhe/edge' }, -- steal (this is non-lua)
  { 'ray-x/starry.nvim', priority = 1000, opts = { disable = { background = false } } }, --  steal the good ones and remove
  { 'thesimonho/kanagawa-paper.nvim', lazy = false, priority = 1000 },
  { 'kevinm6/kurayami.nvim', priority = 1000 }, --- TODO:steal + improve
  { 'loganswartz/sunburn.nvim', dependencies = { 'loganswartz/polychrome.nvim' } }, -- needs additional plugin
  { 'ptdewey/darkearth-nvim', priority = 1000 }, -- brown af

  -- ── Late 2025: ──────────────────────────────────────────────────────
  { 'pineapplegiant/spaceduck' }, -- why is the statusbar light?? annoying
  { 'diegoulloao/neofusion.nvim', priority = 1000, opts = {} }, -- actually unique
  { 'Shatur/neovim-ayu' }, --opts = { mirage = false, terminal = true, overrides = {} } },
  -- ── removed Lazy=False from: ────────────────────────────────────────
  { 'jwbaldwin/oscura.nvim', priority = 1000, opts = {} }, --(L=F) deep colors, see help/readme.md for config
  -- ──────────────────────────────────────────────────────────────────────
  { 'sontungexpt/witch', priority = 1000, lazy = false }, -- spooky witch. if run setup() it messes up all theme :)
  { 'yorumicolors/yorumi.nvim' },
  { 'rose-pine/neovim', name = 'rose-pine' }, -- its rose pine
  { 'ramojus/mellifluous.nvim', opts = { colorset = 'alduin', mellifluous = { neutral = false } } }, --'kanagawa_dragon'
  {
    'ilof2/posterpole.nvim',
    priority = 1000,
    opts = { brightness = -1, fg_saturation = 8, bg_saturation = -2 },
  },

  -- ── chopping block ──────────────────────────────────────────────────
}
