return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "HatNotes",
        path = "~/HatNotes/",
      },
    },

    -- Subdirectorio predeterminado para nuevas notas generales
    notes_subdir = "0-Inbox",

    use_advanced_uri = true,

    picker = {
      name = "snacks.pick",
    },

    -- Configuración de notas diarias
    daily_notes = {
      folder = "3-Logs",
      date_format = "%Y-%m-%d",
      alias_format = "%A, %B %d",
      template = "daily.md",
    },

    templates = {
      subdir = "7-Tmpl",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
      tags = "",

      -- Plantillas específicas para cada tipo de nota
      new_note = "inbox.md",
      daily = "daily.md",
    },

    mappings = {
      ["gf"] = {
        action = function()
          return require("obsidian").util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true },
      },
      ["<leader>ch"] = {
        action = function()
          return require("obsidian").util.toggle_checkbox()
        end,
        opts = { buffer = true },
      },
      ["<cr>"] = {
        action = function()
          return require("obsidian").util.smart_action()
        end,
        opts = { buffer = true, expr = true },
      },
    },
  },
}
