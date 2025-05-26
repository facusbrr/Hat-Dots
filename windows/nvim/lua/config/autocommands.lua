-- config/autocommands.lua
-- Autocomandos útiles para mejorar la experiencia en Neovim

local api = vim.api

-- Resaltar texto copiado
api.nvim_create_autocmd("TextYankPost", {
  desc = "Resaltar cuando se copia texto (yank)",
  group = api.nvim_create_augroup("YankHighlight", { clear = true }),
  callback = function()
    vim.highlight.on_yank({ timeout = 300 })
  end,
})

-- Eliminar espacios en blanco al guardar
api.nvim_create_autocmd("BufWritePre", {
  desc = "Eliminar espacios en blanco al final",
  group = api.nvim_create_augroup("TrimWhiteSpace", { clear = true }),
  callback = function()
    local save = vim.fn.winsaveview()
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.winrestview(save)
  end,
})

-- Recargar automáticamente los archivos Lua de configuración al guardarlos
api.nvim_create_autocmd("BufWritePost", {
  desc = "Recargar automáticamente init.lua y otros archivos lua",
  pattern = { "init.lua", "lua/**/*.lua" },
  group = api.nvim_create_augroup("ReloadConfig", { clear = true }),
  callback = function(args)
    vim.cmd("source " .. args.file)
    vim.notify("Configuración recargada: " .. args.file, vim.log.levels.INFO)
  end,
})

-- Abrir automáticamente Netrw/Oil si se abre una carpeta (si usás oil.nvim)
api.nvim_create_autocmd("VimEnter", {
  desc = "Abrir Oil si se abre un directorio",
  group = api.nvim_create_augroup("OpenOilOnDir", { clear = true }),
  callback = function()
    local oil_ok, oil = pcall(require, "oil")
    local arg0 = vim.fn.argv(0)
    if oil_ok and arg0 and type(arg0) == "string" and vim.fn.isdirectory(arg0) == 1 then
      oil.open()
    end
  end,
})

-- Volver a la última posición del cursor al abrir un archivo
api.nvim_create_autocmd("BufReadPost", {
  desc = "Volver a la última posición del cursor",
  group = api.nvim_create_augroup("RestoreCursor", { clear = true }),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})
