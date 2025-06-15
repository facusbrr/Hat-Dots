-- Configuración del gestor de plugins Lazy.nvim

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

-- if vim.fn.has("wsl") == 1 then
--  vim.g.clipboard = {
--   name = "win32yank",
--   copy = { ["+"] = "win32yank.exe -i --crlf", ["*"] = "win32yank.exe -i --crlf" },
-- paste = { ["+"] = "win32yank.exe -o --lf", ["*"] = "win32yank.exe -o --lf" },
-- cache_enabled = false,
--}
--end

-- Windows clipboard configuration
if vim.fn.has("win32") == 1 then
  vim.opt.shell = "pwsh.exe"
  vim.opt.shellcmdflag =
    "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
  vim.opt.shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait"
  vim.opt.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s"
  vim.opt.shellquote = ""
  vim.opt.shellxquote = ""

  -- Clipboard usando win32yank (UTF-8 seguro)
  vim.g.clipboard = {
    name = "win32yank",
    copy = { ["+"] = "win32yank.exe -i --crlf", ["*"] = "win32yank.exe -i --crlf" },
    paste = { ["+"] = "win32yank.exe -o --lf", ["*"] = "win32yank.exe -o --lf" },
    cache_enabled = false,
  }
end

require("lazy").setup({
  spec = {
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },

    -- TypeScript/JavaScript
    { import = "lazyvim.plugins.extras.lang.typescript" },

    -- Markdown avanzado y preview
    { import = "lazyvim.plugins.extras.lang.markdown" },

    -- Biome y Prettier: Formateadores
    { import = "lazyvim.plugins.extras.formatting.prettier" },
    { import = "lazyvim.plugins.extras.formatting.biome" },

    -- Mini-files: mini explorador de archivos (liviano y útil)
    { import = "lazyvim.plugins.extras.editor.mini-files" },

    -- Surround: edición rápida de paréntesis, comillas, etc.
    { import = "lazyvim.plugins.extras.coding.mini-surround" },

    -- Snacks extras: si usas mucho snacks y quieres pickers/archivos rápidos
    { import = "lazyvim.plugins.extras.editor.snacks_picker" },
    { import = "lazyvim.plugins.extras.editor.snacks_explorer" },

    -- (Opcional) AI/Copilot: solo si usás GitHub Copilot
    -- { import = "lazyvim.plugins.extras.ai.copilot" },
    -- { import = "lazyvim.plugins.extras.ai.copilot-chat" },

    -- Tus propios plugins
    { import = "plugins" },
  },
  defaults = { lazy = false, version = false },
  install = { colorscheme = { "kanagawa", "tokyonight" } },
  checker = { enabled = true },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
