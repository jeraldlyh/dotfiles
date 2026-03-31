return {
  "OXY2DEV/markview.nvim",
  lazy = false,
  dependencies = { "saghen/blink.cmp" },
  opts = {
    preview = {
      enable = false,
      filetypes = { "markdown", "codecompanion" },
      ignore_buftypes = {},
    },
  },
  keys = {
    {
      "<leader>mt",
      "<cmd>Markview toggle<cr>",
      desc = "Toggle markdown preview",
    },
    {
      "<leader>ms",
      "<cmd>Markview splitToggle<cr>",
      desc = "Toggle markdown preview in split",
    },
  },
}
