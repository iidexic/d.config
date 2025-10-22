--# ── 0. load main config manager module ────────────────────────────
local configure = require 'settings.apply'

--# ── 1. Pre-lazy config setup  ─────────────────────────────────────

configure.theme 'evergarden'
configure.prelazy()

require('neovide_config').neovide_config()
--# ── 2. Lazy init + all plugin setup  ──────────────────────────────

require('dlazyinit').LazyPluginSetup()

--# ── 3. Post-lazy config setup  ────────────────────────────────────

configure.postlazy()

--===============================================================================
--===============================================================================
--><-><-><-><-><-><-><-><-><-><-><-><-><-><-><-><-><-><-><-><-><-><-><-><-><-><--
--===============================================================================
--===============================================================================
--------------------------------------------------------------------------------
--!NOTE: DO NOT DELETE BELOW
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
