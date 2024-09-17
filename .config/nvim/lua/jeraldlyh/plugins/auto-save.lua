return {
  "okuuva/auto-save.nvim",
  cmd = "ASToggle",
  enabled = false,
  event = "InsertLeave",
  opts = {
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
  },
}
