return {
  "norcalli/nvim-colorizer.lua",
  config = function()
    require("colorizer").setup(
      { "css", "html", "javascript", "typescript", "typescriptreact", "javascriptreact", "vue", "svelte" },
      {
        RGB = true,
        RRGGBB = true,
        names = false,
        RRGGBBAA = true,
        rgb_fn = true,
        hsl_fn = true,
        css = false,
        css_fn = true,
        mode = "background",
      }
    )
  end,
}
