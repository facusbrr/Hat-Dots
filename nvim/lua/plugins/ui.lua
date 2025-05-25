-- Función auxiliar para abreviar los modos en lualine
local function format_mode(mode)
  local map = {
    ["NORMAL"]     = "N",
    ["O-PENDING"]  = "N?",
    ["INSERT"]     = "I",
    ["VISUAL"]     = "V",
    ["V-BLOCK"]    = "VB",
    ["V-LINE"]     = "VL",
    ["V-REPLACE"]  = "VR",
    ["REPLACE"]    = "R",
    ["COMMAND"]    = "!",
    ["SHELL"]      = "SH",
    ["TERMINAL"]   = "T",
    ["EX"]         = "X",
    ["S-BLOCK"]    = "SB",
    ["S-LINE"]     = "SL",
    ["SELECT"]     = "S",
    ["CONFIRM"]    = "Y?",
    ["MORE"]       = "M",
  }
  return map[mode] or mode
end

return {
  -- lualine: barra inferior
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        theme = "kanagawa",
        icons_enabled = true,
      },
      sections = {
        lualine_a = {
          {
            "mode",
            icon = "ރ",
          },
        },
      },
      extensions = {
        "quickfix",
        {
          filetypes = { "oil" },
          sections = {
            lualine_a = {
              {
                "mode",
                fmt = format_mode,
              },
            },
            lualine_b = {
              function()
                local ok, oil = pcall(require, "oil")
                if not ok then return "" end
                local path = vim.fn.fnamemodify(oil.get_current_dir(), ":~")
                return path .. " %m"
              end,
            },
          },
        },
      },
    },
  },

  -- snacks.nvim: dashboard de inicio moderno
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        sections = {
          { section = "header" },
          { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
          { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
          { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
          {
            pane = 2,
            icon = " ",
            title = "Git Status",
            section = "terminal",
            enabled = function()
              return require("snacks.git").get_root() ~= nil
            end,
            cmd = "git status -sb",
            height = 3,
            padding = 1,
            ttl = 600,
            indent = 3,
          },
          { section = "startup" },
        },
        preset = {
          header = [[
 ██░ ██  ▄▄▄      ▄▄▄█████▓
▓██░ ██▒▒████▄    ▓  ██▒ ▓▒
▒██▀▀██░▒██  ▀█▄  ▒ ▓██░ ▒░
░▓█ ░██ ░██▄▄▄▄██ ░ ▓██▓ ░
░▓█▒░██▓ ▓█   ▓██▒  ▒██▒ ░
 ▒ ░░▒░▒ ▒▒   ▓▒█░  ▒ ░░
 ▒ ░▒░ ░  ▒   ▒▒ ░    ░
 ░  ░░ ░  ░   ▒     ░
 ░  ░  ░      ░  ░
          ]],
          keys = {
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
      },
    },
  },

  -- incline.nvim: mostrar buffer activo en barra superior
  { "b0o/incline.nvim", opts = {} },

  -- nvim-docs-view: panel lateral de documentación
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-context",
        opts = { mode = "cursor", max_lines = 3 },
      },
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        init = function()
          require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
        end,
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = { mode = "cursor", max_lines = 3 },
  },
  {
    "ldelossa/nvim-docs-view",
    cmd = { "DocsViewToggle", "DocsViewOpen", "DocsViewClose" },
    keys = {
      { "<leader>cd", "<cmd>DocsViewToggle<cr>", desc = "Ver documentación (Docs View)" },
    },
    opts = {},
  },

  -- zen-mode.nvim: modo enfoque sin distracciones
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {},
    keys = {
      { "<leader>uz", "<cmd>ZenMode<cr>", desc = "Toggle Zen Mode" },
    },
  },

  -- Comentarios TODO, FIXME, HACK, etc.
  {
    "folke/todo-comments.nvim",
    version = "*",
  },
}

