local root_files = {
  "settings.gradle",
  "settings.gradle.kts",
  "build.xml",
  "pom.xml",
  "build.gradle",
  "build.gradle.kts",
}

---@type vim.lsp.Config
return {
  filetypes = { "kotlin" },
  root_markers = root_files,
  cmd = { "kotlin-language-server" },
  init_options = {
    storagePath = vim.fs.root(vim.fn.expand("%:p:h"), root_files),
  },
}
