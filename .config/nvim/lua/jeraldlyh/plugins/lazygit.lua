return {
  "kdheepak/lazygit.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = {
    "LazyGit",
    "LazyGitConfig",
    "LazyGitCurrentFile",
    "LazyGitFilter",
    "LazyGitFilterCurrentFile",
  },
  lazy = false,
  config = function()
    local keymap = vim.keymap

    keymap.set("n", "<leader>gg", "<cmd>LazyGit<cr>", { desc = "Open Lazy git" })
  end,
}
