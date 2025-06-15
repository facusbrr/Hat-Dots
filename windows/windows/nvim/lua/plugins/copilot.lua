return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "InsertEnter",
    opts = {
      suggestion = {
        enabled = true, -- Mostrar sugerencias flotantes
        auto_trigger = false, -- No autocompletar por defecto
        keymap = {
          accept = "<C-l>", -- Aceptar sugerencia con Ctrl+L
          next = "<C-]>",
          prev = "<C-[>",
          dismiss = "<C-/>",
        },
      },
      panel = { enabled = false },
    },
    config = function(_, opts)
      require("copilot").setup(opts)
    end,
  },
}
