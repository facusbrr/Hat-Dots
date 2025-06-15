-- This file contains the configuration for various UI-related plugins in Neovim.
-- The configuration is structured as a table of plugin specifications that will be loaded by a plugin manager.

-- Personal statusline mode formatting
-- This table defines how mode names are displayed in the statusline
-- It maps full mode names to shorter, more concise representations
local mode = {
  "mode",
  fmt = function(s)
    local mode_map = {
      ["NORMAL"] = "N",
      ["O-PENDING"] = "N?",
      ["INSERT"] = "I",
      ["VISUAL"] = "V",
      ["V-BLOCK"] = "VB",
      ["V-LINE"] = "VL",
      ["V-REPLACE"] = "VR",
      ["REPLACE"] = "R",
      ["COMMAND"] = "!",
      ["SHELL"] = "SH",
      ["TERMINAL"] = "T",
      ["EX"] = "X",
      ["S-BLOCK"] = "SB",
      ["S-LINE"] = "SL",
      ["SELECT"] = "S",
      ["CONFIRM"] = "Y?",
      ["MORE"] = "M",
    }
    return mode_map[s] or s
  end,
}

return {
  -- Todo comments plugin for highlighting TODO, FIXME, etc. in comments
  { "folke/todo-comments.nvim", version = "*" },

  -- Which-key plugin for displaying key bindings in a popup
  {
    "folke/which-key.nvim",
    event = "VeryLazy", -- Load this plugin during VeryLazy event
    opts = {
      preset = "classic", -- Use the classic preset
      win = { border = "single" }, -- Set single-line border for the popup window
    },
  },

  -- Docs view plugin for displaying documentation in a split window
  {
    "amrbashir/nvim-docs-view",
    lazy = true, -- Lazy-load this plugin
    cmd = "DocsViewToggle", -- Load when DocsViewToggle command is used
    opts = {
      position = "right", -- Display docs on the right side
      width = 60, -- Set width to 60 columns
    },
  },

  -- Lualine statusline plugin
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy", -- Load during VeryLazy event
    requires = { "nvim-tree/nvim-web-devicons", opt = true }, -- Require devicons plugin
    opts = {
      options = {
        theme = "kanagawa", -- Use kanagawa colorscheme
        icons_enabled = true, -- Enable icons
      },
      sections = {
        lualine_a = {
          {
            "mode",
            icon = "ރ", -- Custom icon for mode display
          },
        },
      },
      extensions = {
        "quickfix", -- Enable quickfix extension
        {
          -- Custom extension for oil.nvim file browser
          filetypes = { "oil" },
          sections = {
            lualine_a = { mode }, -- Use custom mode formatter
            lualine_b = {
              function()
                -- Display current oil directory path
                local ok, oil = pcall(require, "oil")
                if not ok then
                  return ""
                end
                local path = vim.fn.fnamemodify(oil.get_current_dir(), ":~")
                return path .. " %m" -- Add modified flag
              end,
            },
          },
        },
      },
    },
  },

  -- Incline plugin for displaying filename in the buffer line
  {
    "b0o/incline.nvim",
    event = "BufReadPre", -- Load when buffer is read
    priority = 1200, -- High priority for loading
    config = function()
      require("incline").setup({
        window = { margin = { vertical = 0, horizontal = 1 } }, -- Set window margins
        hide = { cursorline = true }, -- Hide when cursor is on the same line
        render = function(props)
          -- Custom render function for buffer names
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          if vim.bo[props.buf].modified then
            filename = "[+] " .. filename -- Show modified indicator
          end
          local icon, color = require("nvim-web-devicons").get_icon_color(filename)
          return { { icon, guifg = color }, { " " }, { filename } }
        end,
      })
    end,
  },

  -- Zen Mode plugin for distraction-free editing
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode", -- Load when ZenMode command is used
    opts = {
      plugins = {
        gitsigns = true, -- Keep gitsigns visible
        tmux = true, -- Hide tmux status
        kitty = { enabled = false, font = "+2" }, -- Kitty terminal settings
        twilight = { enabled = true }, -- Enable twilight dimming plugin
      },
    },
    keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } }, -- Keybinding
  },

  -- Snacks.nvim plugin for dashboard, notification, and UI components
  {
    "folke/snacks.nvim",
    opts = {
      notifier = {}, -- Notification component configuration
      image = {}, -- Image display component configuration
      picker = {
        -- Configuration for file picker functionality
        matcher = {
          fuzzy = true, -- Enable fuzzy matching
          smartcase = true, -- Enable smart case matching
          ignorecase = true, -- Ignore case when matching
          filename_bonus = true, -- Give bonus to filename matches
        },
        sources = {
          explorer = {
            matcher = {
              fuzzy = true,
              smartcase = true,
              ignorecase = true,
              filename_bonus = true,
              sort_empty = false, -- Don't sort when input is empty
            },
          },
        },
      },
      dashboard = {
        -- Dashboard configuration with various sections
        sections = {
          -- Logo personalizado (HEADER)
          { section = "header" },
          -- Keymaps destacados con color
          { icon = " ", title = "Keymaps", section = "keys", color = "#E6C384", indent = 2, padding = 1 },
          -- Archivos recientes
          {
            icon = " ",
            title = "Recent Files",
            section = "recent_files",
            color = "#7E9CD8",
            indent = 2,
            padding = 1,
          },
          -- Proyectos
          { icon = " ", title = "Projects", section = "projects", color = "#98BB6C", indent = 2, padding = 1 },
          -- Git Status (solo si hay repo git)
          {
            pane = 2,
            icon = " ",
            title = "Git Status",
            section = "terminal",
            color = "#FFA066",
            enabled = function()
              -- Only show if in a git repository
              return Snacks.git.get_root() ~= nil
            end,
            cmd = "git status --short --branch --renames",
            height = 7,
            padding = 1,
            ttl = 300, -- Time to live in seconds
            indent = 3,
          },
          -- Startup info
          { section = "startup" },
        },
        preset = {
          -- ASCII art header for dashboard
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
          -- Dashboard shortcut keys
          keys = {
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            {
              icon = " ",
              key = "c",
              desc = "Config",
              action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
            },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
      },
    },
  },
}
