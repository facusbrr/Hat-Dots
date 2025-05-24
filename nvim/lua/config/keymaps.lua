-- Keymaps generales que no requieren which-key
vim.g.mapleader = " "
local map = vim.keymap.set

local wk = require("which-key")

wk.add({
  { "<leader>o", group = "Obsidian" }, -- group
  { "<leader>on", "<cmd>ObsidianNew<CR>", desc = "Nueva Nota" },
  { "<leader>of", "<cmd>ObsidianQuickSwitch<CR>", desc = "Buscar Nota" },
  { "<leader>ot", "<cmd>ObsidianToday<CR>", desc = "Nota de Hoy" },
  { "<leader>od", "<cmd>ObsidianDailies<CR>", desc = "Ver Diarios", group = "Obsidian" },
}, { mode = "n" })

-- Guardar con Ctrl+S
map("n", "<C-s>", function()
  if vim.fn.empty(vim.fn.expand("%:t")) == 1 then
    vim.notify("No hay archivo para guardar", vim.log.levels.WARN)
    return
  end
  local filename = vim.fn.expand("%:t")
  local success, err = pcall(function() vim.cmd("silent! write") end)
  if success then
    vim.notify("✔️ " .. filename .. " guardado")
  else
    vim.notify("❌ Error: " .. err, vim.log.levels.ERROR)
  end
end, { noremap = true, silent = true, desc = "Guardar archivo" })

-- Mover entre ventanas sin líder
map("n", "<C-h>", "<C-w>h", { desc = "Mover a izquierda" })
map("n", "<C-j>", "<C-w>j", { desc = "Mover abajo" })
map("n", "<C-k>", "<C-w>k", { desc = "Mover arriba" })
map("n", "<C-l>", "<C-w>l", { desc = "Mover a derecha" })

