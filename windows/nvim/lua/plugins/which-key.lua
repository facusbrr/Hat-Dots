return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    require("which-key").setup()
    require("config.keymaps") -- carga tus keymaps aquí
  end,
}
