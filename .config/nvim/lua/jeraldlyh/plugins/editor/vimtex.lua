return {
  "lervag/vimtex",
  lazy = false,
  enabled = true,
  init = function()
    vim.g.vimtex_view_method = "skim"
    vim.g.vimtex_view_general_viewer = "Skim"
  end,
}
