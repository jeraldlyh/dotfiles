return {
  "folke/which-key.nvim",
  depedencies = {},
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500

    vim.keymap.set("n", "<leader>fk", function()
      require("snacks").picker.keymaps()
    end, { desc = "Find keymaps" })
  end,
  opts = {},
}
