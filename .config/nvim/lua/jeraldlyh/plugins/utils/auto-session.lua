return {
  "rmagatti/auto-session",
  enabled = true,
  config = function()
    local auto_session = require("auto-session")
    local keymap = vim.keymap

    local function restore_filetypes()
      vim.schedule(function()
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          if vim.api.nvim_buf_is_loaded(buf) then
            local buftype = vim.bo[buf].buftype
            local name = vim.api.nvim_buf_get_name(buf)
            local filetype = vim.bo[buf].filetype

            if buftype == "" and name ~= "" and filetype == "" then
              vim.api.nvim_buf_call(buf, function()
                vim.cmd("silent! filetype detect")
              end)
            end
          end
        end
      end)
    end

    auto_session.setup({
      suppressed_dirs = { "~/" },
      post_restore_cmds = { restore_filetypes },
    })

    keymap.set("n", "<leader>wr", "<cmd>SessionRestore<cr>", { desc = "Restore session" })
    keymap.set("n", "<leader>ws", "<cmd>SessionSave<cr>", { desc = "Save session" })
    keymap.set("n", "<leader>wt", "<cmd>SessionToggleAutoSave<cr>", { desc = "Toggle auto save for session" })
  end,
}
