---@type vim.lsp.Config
return {
  settings = {
    yaml = {
      customTags = {
        "!reference sequence",
        "!reference mapping",
        "!reference scalar",
      },
      schemaStore = {
        url = "https://www.schemastore.org/api/json/catalog.json",
        enable = true,
      },
      schemas = {
        ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = ".gitlab-ci.{yml,yaml}",
      },
    },
  },
}
