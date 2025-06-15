-- Plugin para mejorar la apariencia visual de archivos Markdown
-- Incluye encabezados numerados, bullets personalizados e integración con Kanagawa

return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = "markdown", -- Solo se carga en archivos Markdown
  dependencies = {
    "nvim-treesitter/nvim-treesitter", -- Para identificar correctamente encabezados/listas
    "echasnovski/mini.nvim", -- Recomendado por el autor (LazyVim ya lo incluye)
  },
  opts = {
    heading = {
      enabled = true,
      sign = true,
      style = "full", -- Estilo decorado (también puede ser 'minimal' o 'simple')
      icons = { "① ", "② ", "③ ", "④ ", "⑤ ", "⑥ " }, -- Encabezados h1 a h6
      left_pad = 1,
    },
    bullet = {
      enabled = true,
      icons = { "●", "○", "◆", "◇" },
      right_pad = 1,
      highlight = "renderMarkdownBullet", -- Grupo de highlight personalizado
    },
  },
  config = function(_, opts)
    require("render-markdown").setup(opts)

    -- ?? Colores personalizados compatibles con Kanagawa Dragon
    vim.api.nvim_set_hl(0, "renderMarkdownBullet", {
      fg = "#957FB8", -- morado suave (Kanagawa's Fuji)
      bold = true,
    })

    -- También puedes ajustar los títulos si querés, por ejemplo:
    vim.api.nvim_set_hl(0, "renderMarkdownHeading", {
      fg = "#7E9CD8", -- azul cielo (Kanagawa's WaveBlue)
      bold = true,
    })
  end,
}
