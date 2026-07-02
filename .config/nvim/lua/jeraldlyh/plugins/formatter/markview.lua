return {
  "OXY2DEV/markview.nvim",
  dependencies = { "saghen/blink.cmp" },
  lazy = true,
  enabled = true,
  ft = { "markdown", "codecompanion", "opencode_output", "kulala_ui" },
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
  config = function()
    require("markview").setup({
      preview = {
        enable = false,
        filetypes = { "markdown", "codecompanion", "opencode_output", "kulala_ui" },
        ignore_buftypes = {},
      },
      renderers = {
        markdown_table = function(buffer, item)
          require("markview-smart-tables").render(buffer, item)
        end,
      },
    })
  end,
}
