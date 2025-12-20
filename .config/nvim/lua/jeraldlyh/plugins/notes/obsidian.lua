return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local obsidian = require("obsidian")
    local keymap = vim.keymap

    local get_datetime = function()
      local offset = os.date("%z")
      local formatted_offset = offset:sub(1, 3) .. ":" .. offset:sub(4, 5)
      return os.date("%Y-%m-%dT%H:%M:%S") .. formatted_offset
    end

    obsidian.setup({
      workspaces = {
        { name = "personal", path = vim.fn.expand("$HOME/Documents/Personal/Vault") },
      },
      completion = { nvim_cmp = true, min_chars = 2, default = true },
      daily_notes = {
        folder = "dailies",
        date_format = "%Y-%m-%d",
        alias_format = "%B %-d, %Y",
        default_tags = { "daily" },
        template = nil,
        default = false,
      },
      templates = {
        folder = "templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
        substitutions = {},
        default = false,
      },
      ui = { enable = false },
      mappings = {
        ["gf"] = {
          action = function()
            return obsidian.util.gf_passthrough()
          end,
          opts = { noremap = false, expr = true, buffer = true, desc = "Go to file" },
        },
        ["<leader>oc"] = {
          action = function()
            return obsidian.util.toggle_checkbox()
          end,
          opts = { buffer = true, desc = "Toggle checkbox" },
        },
      },
      note_frontmatter_func = function(note)
        if note.title then
          note:add_alias(note.title)
        end

        local out = {
          id = string.gsub(string.lower(note.id), "%s+", "-"),
          aliases = note.aliases,
          tags = note.tags,
        }

        if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
          for k, v in pairs(note.metadata) do
            out[k] = v
          end
        end

        return out
      end,
      callbacks = {
        pre_write_note = function(_, note)
          if note.metadata == nil or note.metadata.created_at == nil then
            note:add_field("created_at", get_datetime())
          end
          note:add_field("updated_at", get_datetime())
        end,
      },
    })

    keymap.set("n", "<leader>oo", "<cmd>ObsidianQuickSwitch<cr>", { desc = "Open Obsidian vault" })
    keymap.set("n", "<leader>on", "<cmd>ObsidianNew<cr>", { desc = "Create new Obsidian note" })
    keymap.set("n", "<leader>ot", "<cmd>ObsidianTemplate<cr>", { desc = "Insert Obsidian template" })
    vim.keymap.set("n", "<leader>ow", function()
      vim.cmd("ObsidianTemplate weekly")
      vim.defer_fn(function()
        local filename = vim.fn.expand("%:t:r")
        local lnum = vim.fn.search("^# title")

        if lnum > 0 then
          vim.fn.setline(lnum, "# " .. filename)
        else
          vim.fn.append(0, "# " .. filename)
        end
      end, 100)
    end, { desc = "Create new weekly note" })
  end,
}
