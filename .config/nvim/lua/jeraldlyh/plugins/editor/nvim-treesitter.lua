return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag",
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  config = function()
    local treesitter = require("nvim-treesitter")
    local languages = {
      "bash",
      "css",
      "dockerfile",
      "helm",
      "html",
      "http",
      "javascript",
      "json",
      "markdown",
      "python",
      "query",
      "tsx",
      "typescript",
      "vim",
      "vimdoc",
      "yaml",
    }

    require("nvim-treesitter.install").prefer_git = true

    treesitter.setup({
      highlight = { enable = true },
      indent = { enable = true },
      autotag = { enable = false },
    })
    treesitter.install(languages)
  end,
}
