# Strip nvim config to essentials (ruthless)

## Context

You're on a fresh branch and want to see how far your config can be stripped down without breaking your actual daily work. Current state: ~110 plugin specs across `lua/plugins/*`, `lua/plugins/_devplugins.lua`, five active `lua/trials/*` files, and ~75 themes across `lua/theme/{themes,more-themes}.lua`. Loader is a custom wrapper (`lua/pluginloader.lua` → `dlazyinit.LazyPluginSetup`) — not a raw lazy.nvim spec tree.

Goal: keep the minimum that supports your actual workflow (Go, Lua/nvim config, Python + Jupyter, Dart/Flutter). Cuts are aggressive on purpose — you said you'd add conveniences back after seeing the floor.

## Keep (~16 plugins)

### Core (non-negotiable)
| Plugin | Why |
|---|---|
| `neovim/nvim-lspconfig` | LSP client wiring |
| `mason-org/mason.nvim` + `mason-org/mason-lspconfig.nvim` | LSP installer — how you get gopls, basedpyright, lua_ls, marksman |
| `saghen/blink.cmp` | Completion. Native has none. |
| `nvim-treesitter/nvim-treesitter` | Highlighting + text objects |
| `stevearc/conform.nvim` | `<leader>f` format — you have it wired to gofmt/stylua/black |
| `folke/lazydev.nvim` | Because you edit this config in Lua — gives you nvim API completion |

### Discovery / navigation
| Plugin | Why |
|---|---|
| `nvim-telescope/telescope.nvim` (+ `plenary.nvim`, `telescope-fzf-native.nvim`) | You have 20+ keymaps wired to it — deepest workflow attachment in the config |
| `nvim-neo-tree/neo-tree.nvim` (+ `nvim-web-devicons`) | Primary file explorer, `\` toggle. You recently migrated to this from mini.files. |
| `folke/which-key.nvim` | Your leader-key surface is huge; without this you won't remember your own bindings |

### Language-specific (all four stacks kept per your answer)
| Plugin | Why |
|---|---|
| `nvim-flutter/flutter-tools.nvim` | Owns dartls (per your project notes). Not replaceable by mason. Keep `ft = { 'dart' }`. |
| `ray-x/go.nvim` | Go quality-of-life beyond gopls — `:GoTest`, struct tag, etc. If you find you only use gopls, this can go too. |
| `benlubas/molten-nvim` | Jupyter. Nothing else covers this. Keep the `cmd` lazy-load. |

### One theme
| Plugin | Why |
|---|---|
| `everviolet/nvim` (evergarden) | The one your `init.lua` actually calls |

### Wildcard — keep unless you know otherwise
| Plugin | Why |
|---|---|
| `echasnovski/mini.nvim` | It's one repo but many modules. If you use `mini.surround`, `mini.ai`, or `mini.align` daily, keep and prune its `setup()` to just those. If you don't, cut it. |

## Cut

### Already disabled (safe delete)
`indent-blankline.nvim`, `semshi`, `hydrovim`, `pymple.nvim`, `zig.vim`, `gosigns.nvim`, `markit.nvim`, `snacks` (in trials, commented). No behavior change.

### UI decoration (native or telescope covers it)
- `stevearc/aerial.nvim`, `hedyhli/outline.nvim` — symbol browsing; use `:Telescope lsp_document_symbols` instead.
- `Bekaboo/dropbar.nvim` — winbar; decorative.
- `akinsho/bufferline.nvim` — tab bar; native `:ls` + `:b<n>` or telescope buffers works.
- `nvimdev/lspsaga.nvim` — nvim 0.11 native LSP UI is fine; blink handles signature help.
- `folke/trouble.nvim` — `vim.diagnostic.setqflist()` + native quickfix covers 90%.
- `folke/todo-comments.nvim` — decorative.
- `j-hui/fidget.nvim` — native `$/progress` shows in `:messages`.
- `stevearc/dressing.nvim`, `numToStr/Comment.nvim`, `LudoPinelli/comment-box.nvim`, `soemre/commentless.nvim`, `danymat/neogen.nvim` — all decorative or replaced by nvim 0.10+ native `gc`.

### QoL you can live without
- `folke/zen-mode.nvim`, `shortcuts/no-neck-pain.nvim` — focus modes.
- `akinsho/toggleterm.nvim`, `willothy/wezterm.nvim`, `willothy/flatten.nvim` — native `:terminal` + `<C-w>` splits.
- `uga-rosa/ccc.nvim` — color picker.
- `romus204/referencer.nvim` — decorative virtual text.
- `famiu/bufdelete.nvim` — `:bd` works.
- `ziontee113/icon-picker.nvim` — rare use.
- `windwp/nvim-autopairs` — blink can auto-pair; opinion call.
- `folke/persistence.nvim` — sessions. You have keys wired but ruthless cut. **Likely add back.**
- `tpope/vim-sleuth` — indent detection.
- `kevinhwang91/nvim-ufo` (+ `promise-async`) — native folding.

### Git (keep gitsigns only)
- **Keep:** `lewis6991/gitsigns.nvim` — 14+ keymaps wired, hunk-level workflow.
- **Cut:** `NeogitOrg/neogit`, `sindrets/diffview.nvim` — you can `:!git` or open lazygit outside nvim. If you find yourself missing neogit specifically, add just that back.

### Debug — cut for now, likely add back
- `mfussenegger/nvim-dap` + `rcarriga/nvim-dap-ui` + `nvim-nio` + `jay-babu/mason-nvim-dap.nvim` + `theHamsta/nvim-dap-virtual-text` + `leoluz/nvim-dap-go`
- Rationale: F-key bindings exist but if you're not actively debugging Go on this branch, it's dead weight. **Add back the whole cluster together when you need it.**

### Motion / search extras
- `leap.nvim`, `flit.nvim`, `leap-spooky.nvim`, `telepath.nvim`, `vim-repeat` (all via `trials/leap_plus.lua`) — native `f`/`F`/`/`/`?` work.
- `MagicDuck/grug-far.nvim` — `:vimgrep` + `:cdo`.
- `desdic/macrothis.nvim`, `chentoast/marks.nvim` — native `q`/`m` work.
- `OXY2DEV/helpview.nvim` — native `:help` is fine.

### Language layer extras
- `maxandron/goplements.nvim` — decorative virtual text for Go interfaces.
- `Mathijs-Bakker/godotdev.nvim` — you didn't select Godot as an active stack.
- `rafcamlet/nvim-luapad` — nice to have; add back if you use it.

### Telescope extras
- `nvim-telescope/telescope-ui-select.nvim`, `jvgrootveld/telescope-zoxide`, `benfowler/telescope-luasnip.nvim`, `catgoose/telescope-helpgrep.nvim` — decorative extensions. Core telescope is enough.

### Themes — cut ~74
Delete `lua/theme/more-themes.lua` entirely. In `lua/theme/themes.lua` keep only the `everviolet/nvim` (evergarden) spec. Update `dlazyinit.lua` to stop loading `more-themes`.

### Custom `_devplugins.lua` — decide per plugin
`miss.nvim`, `dur.nvom`, `material.nvim`, `scratch.nvim` are all under your own `iidexic/` github. Ruthless cut says drop them, but these are your own work — keep whichever ones you actually use. If in doubt, cut and add back individually.

## How to execute (when you exit plan mode)

The custom loader means cutting is done by editing the `files` and `trials` arrays in `lua/dlazyinit.lua` (lines ~10–39 and ~58–69) and/or deleting the corresponding files under `lua/plugins/` and `lua/trials/`.

Two viable strategies:
1. **Delete files.** Remove entries from `dlazyinit.lua` first, then delete the underlying `lua/plugins/*.lua` files. Cleanest final state.
2. **Comment out in `dlazyinit.lua`, leave files.** Faster to revert. Downside: dead files accumulate (you already have this pattern — see the "Previously Removed" comment block at `dlazyinit.lua:41-54`).

Also touch:
- `lua/plugins/godot.lua` — this file is confusingly a grab-bag (contains flutter-tools, go.nvim, luapad, hydrovim, pymple, zig, godotdev, goplements, gosigns). You'll want to split kept specs (flutter-tools, go.nvim) into a single `lang.lua` and delete the rest.
- `lua/plugins/lsp/mason.lua` — prune the `ensure_installed` LSP list to just what you use.
- `lua/plugins/treesitters.lua` — prune `ensure_installed` parsers similarly.
- Any keymaps in `lua/settings/keymaps.lua` (or equivalent) that reference cut plugins will error on load — grep for `require('trouble')`, `require('neogit')`, etc. before restart.

## Verification

1. `nvim --startuptime /tmp/st.log +q` before and after — expect the total to drop significantly.
2. Open nvim in this repo. Confirm: LSP attaches on a `.lua` file, `<leader>f` formats, `\` opens neo-tree, `<leader>ff` opens telescope files, `]c`/`[c` navigates gitsigns hunks.
3. `:DcfgStat` — your custom command from `pluginloader.lua` — will report the new plugin count. Expect ~16–20 plus dependencies.
4. Open a `.go`, `.dart`, `.py`, and `.lua` file in turn and confirm LSP attaches for each.
5. `:checkhealth` — flag anything red that isn't expected (e.g. removed DAP is fine).

## What to add back first (predictions)

Based on your keymap density, these are the most likely regrets from the "ruthless" list:
1. `persistence.nvim` — you use sessions.
2. `nvim-dap` cluster — for Go debugging.
3. `neogit` — heavier git ops.
4. `mini.nvim` (if cut) — `mini.surround` in particular.
5. `nvim-autopairs` — muscle memory.
