return {
  {
    "olimorris/onedarkpro.nvim",
    priority = 1000,
    config = function()
      require("onedarkpro").setup({
        highlights = {
          Comment = { italic = true },
          Directory = { bold = true },
          ErrorMsg = { italic = true, bold = true },
        },
        options = {
          cursorline = false,
          transparency = true,
          lualine_transparency = true,
        },
      })

      vim.cmd([[colorscheme onedark]])
    end,
  },
}
