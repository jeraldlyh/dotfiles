return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local gitsigns = require("gitsigns")
    local keymap = vim.keymap

    gitsigns.setup()

    keymap.set("n", "g3", "<cmd>Gitsigns prev_hunk<cr>", { desc = "Next hunk" })
    keymap.set("n", "g4", "<cmd>Gitsigns next_hunk<cr>", { desc = "Previous hunk" })
    keymap.set("n", "<leader>gd", "<cmd>Gitsign diffthis<cr>", { desc = "View diff" })
    keymap.set("n", "<leader>gD", "<cmd>Gitsign diffthis ~<cr>", { desc = "View diff (~)" })
    keymap.set("n", "<leader>gB", "<cmd>Gitsign toggle_current_line_blame<cr>", { desc = "Toggle blame" })
    keymap.set("n", "<leader>gb", "<cmd>Gitsign blame_line {full = true}<cr>", { desc = "Blame line" })
    keymap.set("n", "<leader>gs", "<cmd>Gitsign stage hunk<cr>", { desc = "Stage hunk" })
    keymap.set("n", "<leader>gr", "<cmd>Gitsign reset_hunk<cr>", { desc = "Reset hunk" })
    keymap.set("n", "<leader>gS", "<cmd>Gitsign stage_buffer<cr>", { desc = "Stage buffer" })
    keymap.set("n", "<leader>gR", "<cmd>Gitsign reset_buffer<cr>", { desc = "Reset buffer" })
    keymap.set("n", "<leader>gu", "<cmd>Gitsign undo_stage_hunk<cr>", { desc = "Undo stage hunk" })
    keymap.set("n", "<leader>gp", "<cmd>Gitsign preview_hunk<cr>", { desc = "Preview hunk" })
    keymap.set("n", "<leader>gt", function()
      local config = require("gitsigns.config").config
      local enable = not config.word_diff

      gitsigns.toggle_word_diff(enable)
      gitsigns.toggle_deleted(enable)
      gitsigns.toggle_linehl(enable)
      gitsigns.toggle_numhl(enable)
    end, { desc = "Toggle inline diff" })
  end,
}
