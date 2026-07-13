return {
  cmd = { "terraform-ls", "serve" },
  filetypes = { "terraform", "terraform-vars" },
  root_markers = { ".terraform", ".git" },
  capabilities = {
    experimental = {
      showReferencesCommandId = "client.showReferences",
    },
  },
  on_attach = function(client, bufnr)
    client.server_capabilities.semanticTokensProvider = nil
    -- vim.lsp.codelens.enable(true, { bufnr = bufnr })
  end,
}
