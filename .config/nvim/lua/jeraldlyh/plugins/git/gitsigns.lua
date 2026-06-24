return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    local gitsigns = require("gitsigns")
    local keymap = vim.keymap

    gitsigns.setup()

    keymap.set("n", "ge", "<cmd>Gitsigns prev_hunk<cr>", { desc = "Previous hunk" })
    keymap.set("n", "gr", "<cmd>Gitsigns next_hunk<cr>", { desc = "Next hunk" })
    keymap.set("n", "<leader>gB", "<cmd>Gitsigns toggle_current_line_blame<cr>", { desc = "Toggle blame" })
    keymap.set("n", "<leader>gb", "<cmd>Gitsigns blame_line {full = true}<cr>", { desc = "Blame line" })
    keymap.set("n", "<leader>gs", "<cmd>Gitsigns stage_hunk<cr>", { desc = "Stage hunk" })
    keymap.set("n", "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>", { desc = "Reset hunk" })
    keymap.set("n", "<leader>gS", "<cmd>Gitsigns stage_buffer<cr>", { desc = "Stage buffer" })
    keymap.set("n", "<leader>gR", "<cmd>Gitsigns reset_buffer<cr>", { desc = "Reset buffer" })
    keymap.set("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", { desc = "Preview hunk" })
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
