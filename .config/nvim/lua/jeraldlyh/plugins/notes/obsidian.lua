return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  dependencies = { "nvim-lua/plenary.nvim" },
  ft = "markdown",
  config = function()
    local obsidian = require("obsidian")

    local get_datetime = function()
      local offset = os.date("%z") --[[@as string]]
      local formatted_offset = offset:sub(1, 3) .. ":" .. offset:sub(4, 5)
      return os.date("%Y-%m-%dT%H:%M:%S") --[[@as string]] .. formatted_offset
    end

    obsidian.setup({
      legacy_commands = false,
      workspaces = {
        { name = "personal", path = vim.fn.expand("$HOME/Documents/Personal/Vault") },
      },
      completion = { blink = true, min_chars = 2, default = true },
      daily_notes = {
        folder = "dailies",
        date_format = "%Y-%m-%d",
        alias_format = "%B %-d, %Y",
        default_tags = { "daily" },
        template = nil,
      },
      templates = {
        folder = "templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
        substitutions = {},
      },
      ui = { enable = false },
      frontmatter = {
        enabled = true,
        func = function(note)
          local out = require("obsidian.builtin").frontmatter(note)

          if out.title == nil and note.title ~= nil then
            out.title = note.title
          end

          out.id = string.gsub(string.lower(note.id), "%s+", "-")
          out.aliases = note.aliases
          out.tags = note.tags

          if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
            for k, v in pairs(note.metadata) do
              out[k] = v
            end
          end

          if out.created_at == nil then
            out.created_at = get_datetime()
          end
          out.updated_at = get_datetime()

          return out
        end,
      },
      callbacks = {
        enter_note = function(note)
          vim.keymap.set("n", "<leader>of", function()
            return require("obsidian").util.gf_passthrough()
          end, { noremap = false, expr = true, buffer = true, desc = "Go to file" })

          vim.keymap.set("n", "<leader>oc", function()
            return require("obsidian").util.toggle_checkbox()
          end, { buffer = true, desc = "Toggle checkbox" })
        end,
      },
    })
  end,
  keys = {
    { "<leader>oo", "<cmd>Obsidian quick_switch<cr>", desc = "Open Obsidian vault" },
    { "<leader>on", "<cmd>Obsidian new<cr>", desc = "Create new Obsidian note" },
    { "<leader>ot", "<cmd>Obsidian template<cr>", desc = "Insert Obsidian template" },
    {
      "<leader>ow",
      function()
        vim.cmd("Obsidian template weekly")
        vim.defer_fn(function()
          local filename = vim.fn.expand("%:t:r")
          local lnum = vim.fn.search("^# title")

          if lnum > 0 then
            vim.fn.setline(lnum, "# " .. filename)
          else
            vim.fn.append(0, "# " .. filename)
          end
        end, 100)
      end,
      desc = "Create new weekly note",
    },
  },
}
