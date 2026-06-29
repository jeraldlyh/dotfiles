return {
  "rest-nvim/rest.nvim",
  ft = "http",
  build = false,
  enabled = false,
  dependencies = {
    "j-hui/fidget.nvim",
    "nvim-neotest/nvim-nio",
    "nvim-treesitter/nvim-treesitter",
    {
      "manoelcampos/xml2lua",
      config = function(plugin)
        package.path = package.path .. ";" .. plugin.dir .. "/?.lua"
      end,
    },
    "lunarmodules/lua-mimetypes",
  },
}
