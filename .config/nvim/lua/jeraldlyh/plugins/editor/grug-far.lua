return {
  "MagicDuck/grug-far.nvim",
  config = function()
    require("grug-far").setup({})

    local keymap = vim.keymap

    keymap.set("n", "<leader>rf", function()
      require("grug-far").open({ prefills = { paths = vim.fn.expand("%") } })
    end, { desc = "Replace in current file" })

    keymap.set("n", "<leader>rF", function()
      require("grug-far").open()
    end, { desc = "Replace in files" })

    keymap.set("v", "<leader>rw", function()
      require("grug-far").with_visual_selection({ prefills = { paths = vim.fn.expand("%") } })
    end, { desc = "Replace in current file (current word)" })

    keymap.set("v", "<leader>rW", function()
      require("grug-far").with_visual_selection()
    end, { desc = "Replace in files (current word)" })
  end,
}
