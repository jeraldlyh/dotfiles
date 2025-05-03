return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  commit = "e76cb03",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")
    local keymap = vim.keymap

    harpoon:setup({})

    keymap.set("n", "<leader>ha", function()
      harpoon:list():add()
    end, { desc = "Add harpoon" })
    keymap.set("n", "<leader>ho", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = "Open harpoons" })

    keymap.set("n", "<leader>1", function()
      harpoon:list():select(1)
    end, { desc = "Go to harpoon 1" })
    keymap.set("n", "<leader>2", function()
      harpoon:list():select(2)
    end, { desc = "Go to harpoon 2" })
    keymap.set("n", "<leader>3", function()
      harpoon:list():select(3)
    end, { desc = "Go to harpoon 3" })
    keymap.set("n", "<leader>4", function()
      harpoon:list():select(4)
    end, { desc = "Go to harpoon 4" })
  end,
}
