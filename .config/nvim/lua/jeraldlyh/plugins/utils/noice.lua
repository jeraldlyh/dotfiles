return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    {
      "rcarriga/nvim-notify",
      opts = { top_down = false, background_colour = "#000000" },
    },
  },
  config = function()
    local keymap = vim.keymap

    require("noice").setup({
      routes = {
        {
          filter = {
            event = "notify",
            find = "No information available",
          },
          opts = { skip = true },
        },
      },
      presets = {
        command_palette = {
          views = {
            cmdline_popup = {
              position = {
                row = "50%",
                col = "50%",
              },
              size = {
                min_width = 60,
                width = "auto",
                height = "auto",
              },
            },
          },
        },
        lsp_doc_border = true,
      },
    })

    keymap.set("n", "<leader>nc", "<cmd>Noice dismiss<cr>", { desc = "Close all notifications" })
  end,
}
