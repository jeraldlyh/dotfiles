local root_markers_primary = {
  ".emmyrc.json",
  ".luarc.json",
  ".luarc.jsonc",
}
local root_markers_secondary = {
  ".luacheckrc",
  ".stylua.toml",
  "stylua.toml",
  "selene.toml",
  "selene.yml",
}
return {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = vim.fn.has("nvim-0.11.3") == 1 and { root_markers_primary, root_markers_secondary, { ".git" } }
    or vim.list_extend(vim.list_extend(root_markers_primary, root_markers_secondary), { ".git" }),

  ---@type lspconfig.settings.lua_ls
  settings = {
    Lua = {
      codeLens = { enable = true },
      hint = { enable = true, semicolon = "Disable" },
      diagnostics = {
        globals = {
          "vim",
          "require",
        },
      },
    },
  },
}
