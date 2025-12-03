vim.env.HTTPS_PROXY = vim.env.COPILOT_PROXY_SERVER or nil
vim.env.NODE_TLS_REJECT_UNAUTHORIZED = vim.env.COPILOT_PROXY_SERVER and "0" or "1"

return {
  "github/copilot.vim",
  config = function()
    vim.g.copilot_no_tab_map = true
    vim.keymap.set(
      "i",
      "<M-Enter>",
      "copilot#Accept('<CR>')",
      { noremap = true, silent = true, expr = true, replace_keycodes = false }
    )
  end,
}
