return {
  "saghen/blink.cmp",
  version = "1.*",
  event = "InsertEnter",
  dependencies = {
    "roobert/tailwindcss-colorizer-cmp.nvim",
  },
  opts = function()
    local icons = {
      Text = "󰉿",
      Method = "m",
      Function = "󰊕",
      Constructor = "",
      Field = "",
      Variable = "󰆧",
      Class = "󰌗",
      Interface = "",
      Module = "",
      Property = "",
      Unit = "",
      Value = "󰎠",
      Enum = "",
      Keyword = "󰌋",
      Snippet = "",
      Color = "󰏘",
      File = "󰈙",
      Reference = "",
      Folder = "󰉋",
      EnumMember = "",
      Constant = "󰇽",
      Struct = "",
      Event = "",
      Operator = "󰆕",
      TypeParameter = "󰊄",
    }

    return {
      keymap = {
        preset = "none",
        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
        ["<Right>"] = { "accept", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
      },
      cmdline = {
        enabled = true,
        keymap = { preset = "inherit" },
        completion = {
          menu = { auto_show = true },
          list = { selection = { preselect = false, auto_insert = false } },
        },
      },
      completion = {
        menu = {
          auto_show = true,
          draw = {
            columns = {
              { "label", "label_description", gap = 1 },
              { "kind_icon", "kind", gap = 1 },
              { "source_name" },
            },
            components = {
              kind_icon = {
                text = function(ctx)
                  local kind = ctx.kind
                  return icons[kind] or ctx.kind_icon
                end,
              },
              kind = {
                text = function(ctx)
                  return ""
                end,
              },
              source_name = {
                text = function(ctx)
                  local names = {
                    lsp = "lsp",
                    path = "path",
                    buffer = "buffer",
                    snippets = "snippet",
                  }
                  return names[ctx.source_name] or (ctx.source_name:lower())
                end,
              },
            },
          },
        },
        documentation = { auto_show = true },
        list = { selection = { preselect = false, auto_insert = false } },
        ghost_text = { enabled = false },
      },
      sources = {
        default = { "lsp", "path", "buffer", "snippets" },
      },
      appearance = {
        nerd_font_variant = "mono",
        kind_icons = icons,
      },
      fuzzy = {
        implementation = "prefer_rust_with_warning",
      },
    }
  end,
  opts_extend = { "sources.default" },
}
