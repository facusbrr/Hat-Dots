vim.g.mapleader = " "
local map = vim.keymap.set
local wk = require("which-key")

-- Keymaps generales sin which-key
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

-- Movimiento entre ventanas
map("n", "<C-h>", "<C-w>h", { desc = "Mover a izquierda" })
map("n", "<C-j>", "<C-w>j", { desc = "Mover abajo" })
map("n", "<C-k>", "<C-w>k", { desc = "Mover arriba" })
map("n", "<C-l>", "<C-w>l", { desc = "Mover a derecha" })

-- Cerrar el highlight
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { silent = true, desc = "Limpiar búsqueda" })

---- Eliminar todos los buffers excepto el actual ----
map("n", "<leader>ba", function()
  local current = vim.fn.bufnr()
  local buffers = vim.fn.getbufinfo({ buflisted = 1 })
  for _, buf in ipairs(buffers) do
    if buf.bufnr ~= current then
      vim.cmd("bdelete " .. buf.bufnr)
    end
  end
  vim.notify("Buffers cerrados excepto el actual", vim.log.levels.INFO)
end, { desc = "Cerrar todos excepto el actual" })

---- Which-Key mappings ----
wk.add({
  -- Grupo Obsidian
  { "<leader>o", group = "Obsidian" },
  { "<leader>on", "<cmd>ObsidianNew<CR>", desc = "Nueva Nota" },
  { "<leader>of", "<cmd>ObsidianQuickSwitch<CR>", desc = "Buscar Nota" },
  { "<leader>ot", "<cmd>ObsidianToday<CR>", desc = "Nota de Hoy" },
  { "<leader>od", "<cmd>ObsidianDailies<CR>", desc = "Ver Diarios", group = "Obsidian" },

  -- Grupo Buscar (Telescope)
  { "<leader>f", group = "Buscar" },
  { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Archivos" },
  { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Buscar texto" },
  { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Buffers" },
  { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Ayuda" },
  { "<leader>fc", "<cmd>Telescope find_files cwd=~/.config/nvim<CR>", desc = "Config NVIM" },

   -- Grupo Buffers
  { "<leader>b", group = "Buffers" },
  { "<leader>bd", "<cmd>bdelete<CR>", desc = "Cerrar Buffer" },
  { "<leader>bn", "<cmd>bnext<CR>", desc = "Siguiente Buffer" },
  { "<leader>bp", "<cmd>bprevious<CR>", desc = "Buffer Anterior" },
  { "<leader>ba", "", desc = "Cerrar todos excepto este" },

  -- Grupo Ventanas
  { "<leader>w", group = "Ventanas" },
  { "<leader>ws", "<cmd>split<CR>", desc = "Dividir Horizontal" },
  { "<leader>wv", "<cmd>vsplit<CR>", desc = "Dividir Vertical" },
  { "<leader>wq", "<cmd>q<CR>", desc = "Cerrar Ventana" },
  { "<leader>wo", "<cmd>only<CR>", desc = "Cerrar otras ventanas" },
  { "<leader>ww", "<C-w>w", desc = "Siguiente ventana" },
  }, { mode = "n" })

