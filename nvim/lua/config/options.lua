local M = {}

function M.setup()
  local swap_dir = vim.fn.expand("~/.local/state/nvim/swap//")
  vim.opt.directory = swap_dir

  if vim.fn.isdirectory(swap_dir) == 0 then
    vim.fn.mkdir(swap_dir, "p")
  end

  vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
      local cmd = "find " .. swap_dir .. " -type f -name '*.swp' -mtime +1 -delete"
      os.execute(cmd)
    end,
  })

  vim.opt.swapfile = true
  vim.opt.backup = false
  vim.opt.writebackup = false

  -- Configurar undofile y undodir correctamente
  local undodir = vim.fn.expand("~/.local/state/nvim/undo")
  vim.opt.undofile = true
  vim.opt.undodir = undodir

  if vim.fn.isdirectory(undodir) == 0 then
    vim.fn.mkdir(undodir, "p")
  end
end

return M

