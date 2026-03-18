return {
  "folke/lazydev.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
  },
  ft = "lua",
  opts = {
    library = {
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      { path = "snacks.nvim", words = { "Snacks" } },
    },
  },
}
