return {
  "pmizio/typescript-tools.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  config = function()
    require("typescript-tools").setup({
      on_attach = function(client, bufnr)
        vim.keymap.set("n", "<leader>oi", "<cmd>TSToolsOrganizeImports<cr>", { desc = "Organize imports" })
        vim.keymap.set("n", "<leader>fa", "<cmd>TSToolsFixAll<cr>", { desc = "Fix all" })
      end,
    })
  end,
}
