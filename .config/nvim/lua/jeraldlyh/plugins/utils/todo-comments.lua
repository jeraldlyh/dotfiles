return {
  "folke/todo-comments.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "nvim-lua/plenary.nvim", "folke/snacks.nvim" },
  config = function()
    local todo_comments = require("todo-comments")
    local keymap = vim.keymap

    keymap.set("n", "]t", function()
      todo_comments.jump_next()
    end, { desc = "Next todo comment" })

    keymap.set("n", "[t", function()
      todo_comments.jump_prev()
    end, { desc = "Previous todo comment" })

    keymap.set("n", "<leader>ft", function()
      require("snacks").picker.todo_comments({ keywords = { "TODO", "FIX" } })
    end, { desc = "Find todo comments" })

    todo_comments.setup()
  end,
}
