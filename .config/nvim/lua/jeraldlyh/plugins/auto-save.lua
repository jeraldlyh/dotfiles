return {
  "okuuva/auto-save.nvim",
  cmd = "ASToggle",
  enabled = false,
  event = "InsertLeave",
  config = function()
    local auto_save = require("auto-save")
    local keymap = vim.keymap

    auto_save.setup({
      execution_message = {
        message = function()
          return "File written"
        end,
        dim = 0.18,
        cleaning_interval = 500,
      },
      condition = function(buf)
        local fn = vim.fn
        local utils = require("auto-save.utils.data")

        if fn.getbufvar(buf, "&modifiable") == 1 and utils.not_in(fn.getbufvar(buf, "&filetype"), {}) then
          return true
        end
        return false
      end,
      write_all_buffers = false,
      debounce_delay = 250,
      noautocmd = false,
      lockmarks = false,
    })

    keymap.set("n", "<leader>as", "<cmd>ASToggle<cr>", { desc = "Toggle auto save" })
  end,
}
