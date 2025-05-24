-- Configura el explorador de archivos nvim-tree

return {
  "nvim-tree/nvim-tree.lua",
  cmd = { "NvimTreeToggle", "NvimTreeFocus" },
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- Íconos para archivos
  },
  keys = {
    { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "Alternar nvim-tree" },
  },
  config = function()
    require("nvim-tree").setup({
      disable_netrw = true,         -- Desactiva el explorador por defecto de Vim
      hijack_netrw = true,          -- Reemplaza el netrw por defecto
      auto_reload_on_write = true,  -- Recarga si se guardan archivos
      view = {
        width = 30,
        side = "left",
        number = false,
        relativenumber = false,
      },
      renderer = {
        highlight_git = true,
        highlight_opened_files = "all",
        icons = {
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
          },
        },
      },
      git = {
        enable = true,
        ignore = false,
      },
      actions = {
        open_file = {
          quit_on_open = false,
        },
      },
      diagnostics = {
        enable = true,
        show_on_dirs = true,
        icons = {
          hint = "",
          info = "",
          warning = "",
          error = "",
        },
      },
      filters = {
        dotfiles = false, -- Cambiar a true si no querés ver archivos ocultos
      },
    })

    -- Comando para cerrar automáticamente si sólo queda el árbol abierto
    vim.api.nvim_create_autocmd("BufEnter", {
      nested = true,
      callback = function()
        if #vim.api.nvim_list_wins() == 1 and vim.bo.filetype == "NvimTree" then
          vim.cmd("quit")
        end
      end,
    })
  end,
}

