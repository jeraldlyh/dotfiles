return {
  "rmagatti/auto-session",
  enabled = false,
  config = function()
    local auto_session = require("auto-session")
    local keymap = vim.keymap

    auto_session.setup({
      suppressed_dirs = { "~/" },
    })

    keymap.set("n", "<leader>wr", "<cmd>SessionRestore<cr>", { desc = "Restore session" })
    keymap.set("n", "<leader>ws", "<cmd>SessionSave<cr>", { desc = "Save session" })
    keymap.set("n", "<leader>wt", "<cmd>SessionToggleAutoSave<cr>", { desc = "Toggle auto save for session" })
  end,
}
