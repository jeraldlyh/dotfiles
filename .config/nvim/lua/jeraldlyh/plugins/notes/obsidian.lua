return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local obsidian = require("obsidian")
    local keymap = vim.keymap

    obsidian.setup({
      workspaces = {
        { name = "personal", path = "~/iCloud/vaults" },
      },
      completion = { nvim_cmp = true, min_chars = 2, default = true },
      daily_notes = {
        folder = "notes/dailies",
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
          opts = { noremap = false, expr = true, buffer = true },
        },
        ["<leader>ch"] = {
          action = function()
            return obsidian.util.toggle_checkbox()
          end,
          opts = { buffer = true },
        },
        ["<cr>"] = {
          action = function()
            return obsidian.util.smart_action()
          end,
          opts = { buffer = true, expr = true },
        },
      },
    })

    keymap.set("n", "<leader>oo", "<cmd>ObsidianQuickSwitch<cr>", { desc = "Open Obsidian vault" })
    keymap.set("n", "<leader>on", "<cmd>ObsidianNew<cr>", { desc = "Create new Obsidian note" })
    keymap.set("n", "<leader>ot", "<cmd>ObsidianTemplate<cr>", { desc = "Insert Obsidian template" })
    keymap.set("n", "<leader>od", ":ObsidianTemplate daily<cr>", { desc = "Create new daily note" })
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
