return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-fzf-native.nvim",
    "nvim-telescope/telescope-ui-select.nvim", -- NUEVO
    build = "make",
  },
  opts = {
    defaults = {
      layout_strategy = "horizontal",
      layout_config = {
        horizontal = { preview_width = 0.5 },
      },
      prompt_prefix = "🔍 ",
      selection_caret = " ",
      winblend = 12,
      borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      sorting_strategy = "ascending",
      file_ignore_patterns = { "node_modules", ".git/", "dist", "build" },
    },
    pickers = {
      find_files = { hidden = true },
      live_grep = {
        additional_args = function()
          return { "--hidden", "--glob", "!.git/" }
        end,
      },
    },
    extensions = {
      ["ui-select"] = {
        require("telescope.themes").get_dropdown {},
      },
    },
  },
  config = function(_, opts)
    local telescope = require("telescope")
    telescope.setup(opts)
    pcall(telescope.load_extension, "fzf")
    pcall(telescope.load_extension, "ui-select")
    -- Colores custom:
    vim.cmd [[
      hi! TelescopePromptBorder guifg=#7E9CD8 guibg=NONE
      hi! TelescopeResultsBorder guifg=#98BB6C guibg=NONE
      hi! TelescopePreviewBorder guifg=#E6C384 guibg=NONE
      hi! TelescopePromptTitle guifg=#C4A7E7 guibg=NONE
      hi! TelescopeResultsTitle guifg=#98BB6C guibg=NONE
      hi! TelescopePreviewTitle guifg=#E6C384 guibg=NONE
    ]]
  end,
}
