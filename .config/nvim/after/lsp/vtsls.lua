return {
  on_attach = function(_, bufnr)
    local function organize_imports()
      vim.lsp.buf.code_action({
        context = { only = { "source.organizeImports" }, diagnostics = {} },
        apply = true,
      })
      vim.lsp.buf.format({ async = true })
    end

    vim.keymap.set("n", "<leader>oi", organize_imports, { desc = "Organize imports", buffer = bufnr })
  end,
  settings = {
    typescript = {
      inlayHints = {
        enumMemberValues = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        parameterNames = { enabled = "literals" },
        parameterTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        variableTypes = { enabled = true },
      },
      format = {
        convertTabsToSpaces = true,
        indentSize = 2,
        tabSize = 2,
      },
    },
    javascript = {
      inlayHints = {
        enumMemberValues = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        parameterNames = { enabled = "literals" },
        parameterTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        variableTypes = { enabled = true },
      },
      format = {
        convertTabsToSpaces = true,
        indentSize = 2,
        tabSize = 2,
      },
    },
  },
}
