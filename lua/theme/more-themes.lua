return {
  -- ╭────────────────────────────── KEEPING ──────────────────────────────╮
  { 'ptdewey/monalisa-nvim', priority = 1000 },
  { 'uloco/bluloco.nvim', lazy = false, priority = 1000, dependencies = { 'rktjmp/lush.nvim' } }, -- LUSH
  {
    'samharju/serene.nvim',
  },
  {
    'katawful/kat.nvim', --[[ tag = 3.1 ]]
  },
  -- { 'roobert/palette.nvim', lazy = false, priority = 1000 },
  { 'mrjones2014/lighthaus.nvim' },
  -- { 'justinsgithub/oh-my-monokai.nvim', opts = { transparent_background = false, terminal_colors = true, devicons = true } },
  {
    'stevedylandev/darkmatter-nvim',
    lazy = false,
    priority = 1000,
  },
  {
    'ricardoraposo/nightwolf.nvim', -- meh. just needs such a minor bg change
    lazy = false,
    priority = 1000,
    opts = {},
  },
  -- { 'pwntester/nautilus.nvim' }, -- might need setup, might need transparent = false
  {
    'adibhanna/forest-night.nvim',
    priority = 1000,
  },
  { 'metalelf0/jellybeans-nvim' },
  { 'uhs-robert/oasis.nvim' },
  { 'sainnhe/edge' }, -- steal (this is non-lua)
  { 'ray-x/starry.nvim', priority = 1000, opts = { disable = { background = false } } }, --  steal the good ones and remove
  { 'titanzero/zephyrium' }, -- zephyr fork. I mean it works better but idk
  { 'thesimonho/kanagawa-paper.nvim', lazy = false, priority = 1000 },
  { 'yashguptaz/calvera-dark.nvim' },
  -- { 'nxvu699134/vn-night.nvim' }, -- super high saturation
  { 'kevinm6/kurayami.nvim', priority = 1000 }, --- TODO:steal + improve
  -- { 'qaptoR-nvim/chocolatier.nvim' },
  { 'nyngwang/nvimgelion' },
  { 'scottmckendry/cyberdream.nvim', opts = { transparent = false } },
  { 'loganswartz/sunburn.nvim', dependencies = { 'loganswartz/polychrome.nvim' } }, -- needs additional plugin
  { 'ptdewey/darkearth-nvim', priority = 1000 }, -- brown af
  {
    '0xstepit/flow.nvim', -- oceanic/quantumy (i do like)
    lazy = false,
    priority = 1000,
    opts = { theme = { transparent = false } },
  },
  -- { 'bakageddy/alduin.nvim', priority = 1000 }, -- another good brown
  { 'rktjmp/lush.nvim' }, -- screw it adding lush
  { 'JLighter/aura.nvim' }, -- lush

  -- ── Late 2025: ──────────────────────────────────────────────────────
  { 'cpea2506/one_monokai.nvim' },
  { 'akinsho/horizon.nvim' }, -- add version = "*" if bad
  { 'pineapplegiant/spaceduck' },
  { 'diegoulloao/neofusion.nvim', priority = 1000, opts = {} }, -- actually unique
  { 'tobi-wan-kenobi/zengarden', opts = { variant = 'orange' } }, -- like
  { 'Shatur/neovim-ayu' }, --opts = { mirage = false, terminal = true, overrides = {} } },
  { 'savq/melange-nvim' },
  -- ── removed Lazy=False from: ────────────────────────────────────────
  { 'jwbaldwin/oscura.nvim', priority = 1000, opts = {} }, --(L=F) deep colors, see help/readme.md for config
  -- ──────────────────────────────────────────────────────────────────────
  { 'drewxs/ash.nvim', priority = 1000 },
  { 'arturgoms/moonbow.nvim' }, -- improve + add to Material d
  { 'sontungexpt/witch', priority = 1000, lazy = false }, -- spooky witch. if run setup() it messes up all theme :)
  { 'craftzdog/solarized-osaka.nvim', lazy = false, priority = 1000, opts = { transparent = false } }, -- best solarized
  { 'numToStr/Sakura.nvim' }, -- its rose pine but darker/vibranter
  -- { 'eddyekofo94/gruvbox-flat.nvim' }, -- idk
  { '2giosangmitom/nightfall.nvim', lazy = false, priority = 1000, opts = {} }, -- Has Maron
  { 'Skardyy/makurai-nvim', priority = 1000 },
  -- { 'yorumicolors/yorumi.nvim' },
  { 'rose-pine/neovim', name = 'rose-pine' }, -- its rose pine
  { 'ramojus/mellifluous.nvim', opts = { colorset = 'kanagawa_dragon', mellifluous = { neutral = false } } },
  { 'dgox16/oldworld.nvim', priority = 1000, lazy = false, opts = { variant = 'cooler' } },
  {
    'ilof2/posterpole.nvim',
    priority = 1000,
    opts = { brightness = -3, fg_saturation = 10, bg_saturation = -4 },
  },
  {
    'ficcdaf/ashen.nvim',
    -- tag = '*', uncomment if issues
    lazy = false,
    priority = 1000,
    opts = {
      style_presets = { bold_functions = true },
    },
  },
  {
    'loctvl842/monokai-pro.nvim',
    opts = {
      override = function()
        return { -- seriously I had to do this shit to make the cursor usable
          Cursor = { bg = '#baaa8a', fg = '#3a301a', sp = '#8a1c2c', bold = true },
        }
      end,
    },
  },

  -- ── chopping block ──────────────────────────────────────────────────
}
