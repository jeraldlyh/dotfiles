return {
  "mistweaverco/kulala.nvim",
  ft = { "http", "rest" },
  event = { "SessionLoadPost", "VimLeavePre" },
  opts = {
    global_keymaps = true,
    global_keymaps_prefix = "<leader>R",
    kulala_keymaps_prefix = "",
    ui = {
      max_response_size = 1024 * 1024 * 5, -- 5 MB
    },
    kulala_keymaps = {
      ["Previous tab"] = false,
      ["Next tab"] = false,
    },
  },
}
