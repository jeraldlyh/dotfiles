return {
  "OXY2DEV/markview.nvim",
  dependencies = { "saghen/blink.cmp" },
  lazy = true,
  enabled = false,
  ft = { "markdown", "codecompanion", "opencode_output" },
  opts = {
    preview = {
      enable = false,
      filetypes = { "markdown", "codecompanion", "opencode_output" },
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
