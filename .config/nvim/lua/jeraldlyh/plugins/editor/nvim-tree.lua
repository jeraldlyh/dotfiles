return {
  "nvim-tree/nvim-tree.lua",
  dependencies = "nvim-tree/nvim-web-devicons",
  cmd = {
    "NvimTreeToggle",
    "NvimTreeFindFileToggle",
    "NvimTreeCollapse",
    "NvimTreeRefresh",
  },
  keys = {
    { "<leader>ee", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file explorer" },
    { "<leader>ef", "<cmd>NvimTreeFindFileToggle<cr>", desc = "Toggle file explorer on current file" },
    { "<leader>ec", "<cmd>NvimTreeCollapse<cr>", desc = "Collapse file explorer" },
    { "<leader>er", "<cmd>NvimTreeRefresh<cr>", desc = "Refresh file explorer" },
    {
      "<leader>ep",
      function()
        require("nvim-tree.api").tree.change_root_to_node()
      end,
      desc = "Change directory",
    },
    {
      "<C-v>",
      function()
        require("nvim-tree.api").node.open.vertical()
      end,
      desc = "Open in vertical split",
    },
  },
  config = function()
    local nvim_tree = require("nvim-tree")

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
  end,
}
