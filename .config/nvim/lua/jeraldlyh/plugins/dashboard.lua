return {
  "nvimdev/dashboard-nvim",
  dependencies = { { "nvim-tree/nvim-web-devicons" } },
  event = "VimEnter",
  config = function()
    local keymap = vim.keymap

    require("dashboard").setup({
      theme = "hyper",
      config = {
        week_header = { enable = true },
        shortcut = {
          {
            desc = "dotfiles",
            group = "Number",
            action = ":e " .. vim.fn.stdpath("config"),
            key = "d",
          },
          {
            desc = "update Lazy",
            group = "Number",
            action = ":Lazy update",
            key = "l",
          },
          {
            desc = "update Mason",
            group = "Number",
            action = ":MasonUpdate",
            key = "m",
          },
        },
      },
    })

    keymap.set("n", "<leader>db", "<cmd>Dashboard<cr>", { desc = "Open dashboard" })
  end,
}
