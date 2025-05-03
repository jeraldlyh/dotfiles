return {
  "fedepujol/move.nvim",
  config = function()
    local move = require("move")
    local keymap = vim.keymap
    local opts = { noremap = true, silent = true }

    move.setup()

    keymap.set("n", "<leader>k", ":MoveLine(-1)<cr>", vim.tbl_extend("force", { desc = "Move line up" }, opts))
    keymap.set("n", "<leader>j", ":MoveLine(1)<cr>", vim.tbl_extend("force", { desc = "Move line down" }, opts))
    keymap.set("v", "<leader>k", ":MoveBlock(-1)<cr>", vim.tbl_extend("force", { desc = "Move block up" }, opts))
    keymap.set("v", "<leader>j", ":MoveBlock(1)<cr>", vim.tbl_extend("force", { desc = "Move block down" }, opts))
  end,
}
