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
}
