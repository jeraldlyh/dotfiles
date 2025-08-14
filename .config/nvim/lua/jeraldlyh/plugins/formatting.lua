return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")
    local keymap = vim.keymap

    conform.setup({
      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        lua = { "stylua" },
      },
      format_on_save = function(bufnr)
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        return { timeout_ms = 1000, async = false, lsp_fallback = true }
      end,
    })

    -- keymap.set("n", "<leader>fm", function()
    --   conform.format({
    --     lsp_fallback = true,
    --     async = true,
    --     timeout_ms = 1000,
    --   })
    -- end, { desc = "Format buffer" })
  end,
}
