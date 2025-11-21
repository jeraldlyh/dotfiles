return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        css = { "prettier" },
        html = { "prettier" },
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        json = { "prettier" },
        lua = { "stylua" },
        markdown = { "prettier" },
        python = { "ruff_format" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        yaml = { "prettier" },
      },
      format_on_save = function(bufnr)
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        return { timeout_ms = 1000, async = false, lsp_fallback = true }
      end,
    })

    -- vim.keymap.set("n", "<leader>fm", function()
    --   local bufnr = vim.api.nvim_get_current_buf()
    --   local filetype = vim.bo[bufnr].filetype
    --   local formatters = require("conform").formatters_by_ft
    --   local opts = {
    --     lsp_fallback = true,
    --     async = true,
    --     timeout_ms = 1000,
    --   }
    --
    --   if formatters[filetype] then
    --     require("conform").format(opts)
    --   else
    --     require("conform").format(vim.tbl_extend("force", opts, { formatters = { "prettier" } }))
    --   end
    -- end, { desc = "Format buffer" })
  end,
}
