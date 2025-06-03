return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false,
    opts = {
      provider = "copilot",
      cursor_applying_provider = "copilot",
      auto_suggestions_provider = "copilot",

      -- ✅ Nuevo lugar para la config de copilot:
      providers = {
        copilot = {
          model = "claude-3.7-sonnet", -- o1-preview | o1-mini | claude-3.7-sonnet
        },
      },

      behaviour = {
        auto_suggestions = false, -- Desactivado por defecto (tu preferencia)
        auto_set_highlight_group = true,
        auto_set_keymaps = true,
        auto_apply_diff_after_generation = false,
        support_paste_from_clipboard = false,
        enable_cursor_planning_mode = true,
      },

      file_selector = {
        provider = "snacks",
        provider_opts = {},
      },

      mappings = {
        diff = {
          ours = "co",
          theirs = "ct",
          all_theirs = "ca",
          both = "cb",
          cursor = "cc",
          next = "]x",
          prev = "[x",
        },
        suggestion = {
          accept = "<M-l>",
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
        jump = {
          next = "]]",
          prev = "[[",
        },
        submit = {
          normal = "<CR>",
          insert = "<C-s>",
        },
        sidebar = {
          apply_all = "A",
          apply_cursor = "a",
          switch_windows = "<Tab>",
          reverse_switch_windows = "<S-Tab>",
        },
      },

      hints = { enabled = false },

      windows = {
        position = "smart",
        wrap = true,
        width = 30,
        sidebar_header = {
          enabled = true,
          align = "center",
          rounded = false,
        },
        input = {
          prefix = "> ",
          height = 8,
        },
        edit = {
          start_insert = true,
        },
        ask = {
          floating = false,
          start_insert = true,
          focus_on_apply = "ours",
        },
      },

      highlights = {
        diff = {
          current = "DiffText",
          incoming = "DiffAdd",
        },
      },

      diff = {
        autojump = true,
        list_opener = "copen",
        override_timeoutlen = 500,
      },

      system_prompt = [[
Este asistente es un clon del usuario, un desarrollador backend experimentado especializado en NodeJS, NestJS y Python con diversos frameworks. Tiene amplia experiencia como Product Owner gestionando proyectos en Jira.

Características clave:
- Profundo conocimiento de arquitecturas backend, patrones de diseño y mejores prácticas
- Experiencia en APIs RESTful, GraphQL y microservicios
- Familiaridad con bases de datos SQL y NoSQL
- Habilidades sólidas en metodologías ágiles, historias de usuario y roadmaps de producto
- Enfoque pragmático para resolver problemas técnicos y de negocio
- Experiencia balanceando requisitos técnicos y necesidades de producto

Al sugerir soluciones, este asistente prioriza enfoques escalables, mantenibles y bien documentados que satisfagan tanto requisitos técnicos como de negocio.
]],
    },

    build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false",

    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
      {
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            use_absolute_path = true,
          },
        },
      },
    },
  },
}
