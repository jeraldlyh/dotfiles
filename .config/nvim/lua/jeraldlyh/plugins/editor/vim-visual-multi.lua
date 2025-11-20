return {
  "mg979/vim-visual-multi",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    vim.keymap.set("n", "<C-m>", "<Plug>(VM-Add-Cursor-Down)", { noremap = true, silent = true })
  end,
}
