-- Configuración para oil.nvim
return {
  "stevearc/oil.nvim",
  opts = {
    default_file_explorer = false, -- lo dejamos en false si también usás nvim-tree
    columns = {
      "icon", -- muestra íconos de archivo
      -- "permissions", -- puedes activar esto si querés ver permisos estilo `ls -l`
    },
    view_options = {
      show_hidden = true,
    },
    keymaps = {
      ["g?"] = "actions.show_help",
      ["<CR>"] = "actions.select",
      ["<C-s>"] = "actions.select_vsplit",
      ["<C-h>"] = "actions.select_split",
      ["<C-p>"] = "actions.preview",
      ["<C-c>"] = "actions.close",
      ["q"] = "actions.close",
      ["<C-r>"] = "actions.refresh",
      ["-"] = "actions.parent", -- ir a la carpeta anterior
    },
    use_default_keymaps = false,
  },
  keys = {
    -- Atajo para abrir Oil en el directorio actual
    {
      "-", -- Suele usarse como atajo común
      function() require("oil").open() end,
      desc = "Abrir Oil (explorador rápido)",
    },
  },
  dependencies = { "nvim-tree/nvim-web-devicons" },
}

