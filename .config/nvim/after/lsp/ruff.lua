---@type vim.lsp.Config
return {
  init_options = {
    settings = {
      lineLength = 100,
      fixAll = true,
      organizeImports = true,
      lint = { enabled = false },
      format = {
        ["quote-style"] = "single",
      },
    },
  },
  on_attach = function(_, bufnr)
    local function organize_imports()
      vim.lsp.buf.code_action({
        context = { only = { "source.fixAll.ruff" }, diagnostics = {} },
        apply = true,
      })
      vim.lsp.buf.code_action({
        context = { only = { "source.organizeImports" }, diagnostics = {} },
        apply = true,
      })
      vim.lsp.buf.format({ async = true })
    end

    vim.keymap.set("n", "<leader>oi", organize_imports, { desc = "Organize imports", buffer = bufnr })
  end,
}
