-- Definir el leader antes de cualquier carga de plugin
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Bootstrap Lazy.nvim si no está instalado
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- Recomiendo especificar la rama estable
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Cargar opciones generales (incluye manejo de swap, backup, undo, etc)
require("config.options").setup()

-- Cargar autocomandos u otras configuraciones
require("config.autocommands")

-- Cargar plugins con lazy.nvim (modularizado en carpeta plugins/)
require("lazy").setup("plugins")

