return {
  "wfxr/minimap.vim",
  build = "cargo install --locked code-minimap",
  lazy = false,
  -- enabled = false,
  cmd = { "Minimap", "MinimapClose", "MinimapToggle", "MinimapRefresh", "MinimapUpdateHighlight" },
}
