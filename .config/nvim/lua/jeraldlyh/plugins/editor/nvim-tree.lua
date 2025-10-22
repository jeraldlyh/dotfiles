return {
  "nvim-tree/nvim-tree.lua",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    local nvim_tree = require("nvim-tree")
    local keymap = vim.keymap
    local nvim_tree_api = require("nvim-tree.api")

    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    nvim_tree.setup({
      view = {
        width = 35,
        relativenumber = true,
      },
      renderer = {
        indent_markers = {
          enable = true,
        },
        icons = {
          glyphs = {
            folder = {
              arrow_closed = "",
              arrow_open = "",
            },
          },
        },
      },
      actions = {
        open_file = {
          window_picker = {
            enable = false,
          },
        },
      },
      filters = {
        custom = { ".DS_Store" },
      },
      git = {
        ignore = false,
      },
    })

    keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle file explorer" })
    keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<cr>", { desc = "Toggle file explorer on current file" })
    keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<cr>", { desc = "Collapse file explorer" })
    keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<cr>", { desc = "Refresh file explorer" })
    keymap.set("n", "<leader>ep", nvim_tree_api.tree.change_root_to_node, { desc = "Change directory" })
    keymap.set("n", "<C-v>", nvim_tree_api.node.open.vertical, { desc = "Open in vertical split" })
  end,
}
