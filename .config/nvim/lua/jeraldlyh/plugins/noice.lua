return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  opts = function(_, opts)
    opts.presets = {
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
    }
  end,
}
