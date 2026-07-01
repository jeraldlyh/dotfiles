return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  lazy = true,
  enabled = false,
  ft = { "markdown", "codecompanion", "opencode_output" },
  config = function()
    require("render-markdown").setup({
      enabled = true,
      render_modes = { "n", "c", "t" },
      debounce = 100,
      file_types = { "markdown", "codecompanion", "opencode_output" },
    })

    vim.keymap.set("n", "<leader>mt", "<cmd>RenderMarkdown toggle<cr>", { desc = "Toggle markdown preview" })
  end,
}
