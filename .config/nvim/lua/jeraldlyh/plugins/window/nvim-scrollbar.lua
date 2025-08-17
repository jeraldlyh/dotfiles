return {
  "petertriho/nvim-scrollbar",
  config = function()
    local one_dark = require("onedarkpro.helpers")
    local colors = one_dark.get_colors()

    require("scrollbar").setup({
      handle = {
        color = colors.bg_highlight,
      },
      marks = {
        Search = { color = colors.orange },
        Error = { color = colors.error },
        Warn = { color = colors.warning },
        Info = { color = colors.info },
        Hint = { color = colors.hint },
        Misc = { color = colors.purple },
      },
    })
  end,
}
