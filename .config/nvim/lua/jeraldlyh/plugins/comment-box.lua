return {
  "fangjunzhou/comment-divider.nvim",
  config = function()
    local keymap = vim.keymap

    keymap.set("n", "<leader>cb", "<cmd>CommentDividerBox<cr>", { desc = "Comment box" })
  end,
}
