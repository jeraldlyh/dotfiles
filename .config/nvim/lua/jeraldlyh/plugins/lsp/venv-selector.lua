return {
  "linux-cultist/venv-selector.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "folke/snacks.nvim",
  },
  ft = "python",
  config = function()
    require("venv-selector").setup({
      select_command = "snacks",
      options = {
        picker_options = {
          snacks = {
            layout = {
              preset = "default",
              preview = { main = false, enabled = false },
              fullscreen = false,
            },
          },
        },
      },
    })

    vim.keymap.set("n", "<leader>vs", "<cmd>VenvSelect<cr>", { desc = "Select Python virtual environment" })
  end,
}
