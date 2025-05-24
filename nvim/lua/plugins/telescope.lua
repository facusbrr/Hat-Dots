-- Configuración para telescope.nvim
return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim", -- Dependencia requerida
    "nvim-telescope/telescope-fzf-native.nvim", -- Mejor rendimiento
    build = "make",
  },
  cmd = "Telescope",
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Buscar archivos" },
    { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Buscar en contenido" },
    { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Buscar buffers" },
    { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Buscar ayuda" },
    { "<leader>fs", "<cmd>Telescope current_buffer_fuzzy_find<CR>", desc = "Buscar en buffer actual" },
  },
  opts = {
    defaults = {
      layout_strategy = "horizontal",
      layout_config = {
        horizontal = { preview_width = 0.5 },
        vertical = { preview_height = 0.5 },
      },
      prompt_prefix = "🔍 ",
      selection_caret = " ",
      sorting_strategy = "ascending",
      file_ignore_patterns = { "node_modules", ".git/", "dist", "build" },
    },
    pickers = {
      live_grep = {
        additional_args = function()
        return { "--hidden", "--glob", "!.git/" } -- incluir archivos ocultos y excluir .git
    end,
    },
      find_files = {
        hidden = true,
      },
    },
  },
  config = function(_, opts)
    local telescope = require("telescope")
    telescope.setup(opts)
    -- Activamos fzf si está instalado
    pcall(telescope.load_extension, "fzf")
  end,
}

