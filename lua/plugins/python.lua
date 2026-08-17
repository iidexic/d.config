-- Python: molten-nvim for interactive `# %%` cell execution.
-- Requires (already installed on this machine):
--   pip install pynvim jupyter_client ipykernel
--   python -m ipykernel install --user  (kernel `python3` registered)
-- After :Lazy install/update, run `:UpdateRemotePlugins` once and restart.
-- Image output uses WezTerm's `imgcat` — no extra plugin needed.

return {
  {
    'benlubas/molten-nvim',
    version = '^1.0.0',
    build = ':UpdateRemotePlugins',
    ft = { 'python', 'markdown', 'quarto' },
    init = function()
      -- Explicit python for pynvim host. Change if you move python.
      vim.g.python3_host_prog = 'C:/Users/derek/AppData/Local/Programs/Python/Python313/python.exe'

      vim.g.molten_image_provider = 'wezterm'
      vim.g.molten_output_win_max_height = 20 -- not doing much when virt text mode on
      vim.g.molten_auto_open_output = false
      vim.g.molten_virt_text_output = true
      vim.g.molten_virt_lines_off_by_1 = true
      vim.g.molten_virt_text_max_lines = 24
      vim.g.molten_wrap_output = true
      vim.g.molten_output_show_more = true
      vim.g.molten_output_crop_border = true
      vim.g.molten_use_border_highlights = true
    end,
    config = function()
      local pat = '^%s*#%s*%%%%'

      local function cell_bounds()
        local total = vim.api.nvim_buf_line_count(0)
        local cur = vim.api.nvim_win_get_cursor(0)[1]
        local s = 1
        for i = cur, 1, -1 do
          local l = vim.api.nvim_buf_get_lines(0, i - 1, i, false)[1] or ''
          if l:match(pat) then
            s = i + 1
            break
          end
        end
        local e = total
        for i = cur + 1, total do
          local l = vim.api.nvim_buf_get_lines(0, i - 1, i, false)[1] or ''
          if l:match(pat) then
            e = i - 1
            break
          end
        end
        return s, e
      end

      local function eval_cell()
        local s, e = cell_bounds()
        vim.fn.MoltenEvaluateRange(s, e)
      end

      local function jump(dir)
        local total = vim.api.nvim_buf_line_count(0)
        local cur = vim.api.nvim_win_get_cursor(0)[1]
        local from, to, step
        if dir == 'next' then
          from, to, step = cur + 1, total, 1
        else
          from, to, step = cur - 1, 1, -1
        end
        for i = from, to, step do
          local l = vim.api.nvim_buf_get_lines(0, i - 1, i, false)[1] or ''
          if l:match(pat) then
            vim.api.nvim_win_set_cursor(0, { i, 0 })
            return
          end
        end
      end

      vim.api.nvim_create_user_command('MoltenEvaluateCell', eval_cell, {})
      vim.api.nvim_create_user_command('MoltenNextCell', function() jump 'next' end, {})
      vim.api.nvim_create_user_command('MoltenPrevCell', function() jump 'prev' end, {})

      -- ── Auto-init per-venv kernel ─────────────────────────────────────────
      -- Detects `.venv` / `venv` in cwd, registers a jupyter kernel named
      -- after the project on first use, then MoltenInits it.
      local function project_venv_python()
        local cwd = vim.fn.getcwd()
        local exe = vim.fn.has 'win32' == 1 and 'Scripts/python.exe' or 'bin/python'
        for _, dir in ipairs { '.venv', 'venv' } do
          local p = cwd .. '/' .. dir .. '/' .. exe
          if vim.fn.filereadable(p) == 1 then return p end
        end
      end

      local function kernel_name()
        local base = vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
        return 'venv-' .. base:gsub('[^%w_-]', '_')
      end

      local function kernel_registered(name)
        local paths = vim.fn.has 'win32' == 1
            and { vim.fn.expand('~/AppData/Roaming/jupyter/kernels/' .. name) }
          or {
            vim.fn.expand('~/.local/share/jupyter/kernels/' .. name),
            vim.fn.expand('~/Library/Jupyter/kernels/' .. name),
          }
        for _, p in ipairs(paths) do
          if vim.fn.isdirectory(p) == 1 then return true end
        end
        return false
      end

      local function ensure_kernel(py, name)
        if kernel_registered(name) then return true end
        vim.notify('Registering jupyter kernel: ' .. name, vim.log.levels.INFO)
        local out = vim.fn.system {
          py, '-m', 'ipykernel', 'install', '--user',
          '--name', name, '--display-name', name,
        }
        if vim.v.shell_error ~= 0 then
          vim.notify('ipykernel install failed:\n' .. out, vim.log.levels.ERROR)
          return false
        end
        return true
      end

      local function smart_init()
        local py = project_venv_python()
        if not py then
          vim.notify('No .venv/venv in cwd — falling back to global python3 kernel', vim.log.levels.WARN)
          vim.cmd 'MoltenInit python3'
          return
        end
        local name = kernel_name()
        if ensure_kernel(py, name) then
          vim.cmd('MoltenInit ' .. name)
        end
      end

      vim.api.nvim_create_user_command('MoltenSmartInit', smart_init, {})

      -- Auto-init once per session on first python file, only if venv detected.
      -- Set `vim.g.molten_no_autoinit = true` before load to disable.
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'python',
        once = true,
        callback = function()
          if vim.g.molten_no_autoinit then return end
          if project_venv_python() then vim.schedule(smart_init) end
        end,
      })
    end,
  },
}
