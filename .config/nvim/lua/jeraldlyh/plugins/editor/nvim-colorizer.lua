return {
  "norcalli/nvim-colorizer.lua",
  config = function()
    require("colorizer").setup({ "*" }, {
      RGB = true,
      RRGGBB = true,
      names = false,
      RRGGBBAA = true,
      rgb_fn = true,
      hsl_fn = true,
      css = false,
      css_fn = true,
      mode = "background",
    })
  end,
}
