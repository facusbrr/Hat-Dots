return {
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("kanagawa").setup({
        compile = false,
        theme = "dragon",
        transparent = true,  -- ← Habilita fondo transparente
        background = {
          dark = "dragon",
          light = "lotus",
        },
        overrides = function(colors)
          return {
            -- Puedes ajustar aún más si lo deseás
            NormalFloat = { bg = "none" },
            FloatBorder = { bg = "none" },
            CursorLine = { bg = colors.palette.sumiInk2 },
            -- Quita el fondo de la línea activa si lo querés más limpio
            Visual = { bg = colors.palette.waveBlue1 },
          }
        end,
      })

      vim.cmd("colorscheme kanagawa")
    end,
  },
}

