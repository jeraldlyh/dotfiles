return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-telescope/telescope.nvim",
    "neovim/nvim-lspconfig",
    "ravitemer/codecompanion-history.nvim",
    "MeanderingProgrammer/render-markdown.nvim",
  },
  config = function()
    local codecompanion = require("codecompanion")
    local keymap = vim.keymap

    codecompanion.setup({
      adapters = {
        opts = {
          allow_insecure = vim.env.PROXY_SERVER ~= nil,
          proxy = vim.env.PROXY_SERVER or nil,
          show_model_choices = true,
        },
      },
      strategies = {
        chat = { adapter = "copilot" },
        inline = { adapter = "copilot" },
      },
      display = {
        chat = {
          window = {
            width = 0.3,
          },
        },
        diff = {
          enabled = true,
          close_chat_at = 240,
          layout = "vertical",
          opts = {
            "internal",
            "filler",
            "closeoff",
            "algorithm:patience",
            "followwrap",
            "linematch:120",
          },
          provider = "split",
        },
      },
      extensions = {
        vectorcode = {},
        history = {
          enabled = true,
          opts = {
            keymap = "gh",
            save_chat_keymap = "sc",
            auto_save = true,
            expiration_days = 0,
            picker = "telescope",
            chat_filter = nil,
            auto_generate_title = true,
            title_generation_opts = {
              adapter = "copilot",
              model = "gpt-4o",
              refresh_every_n_prompts = 0,
              max_refreshes = 3,
            },
            continue_last_chat = false,
            delete_on_clearing_chat = false,
            dir_to_save = vim.fn.expand("~/iCloud/ai/codecompanion-chat"),
            enable_logging = false,
          },
          memory = {
            auto_create_memories_on_summary_generation = true,
            vectorcode_exe = "vectorcode",
            tool_opts = {
              default_num = 10,
            },
            notify = true,
            index_on_startup = false,
          },
        },
      },
    })

    keymap.set("n", "<leader>co", codecompanion.toggle, { desc = "Toggle AI chat" })
    keymap.set("n", "<leader>ct", codecompanion.actions, { desc = "Show AI actions" })
    keymap.set("v", "<leader>ca", codecompanion.add, { desc = "Add visual selected to chat" })
    keymap.set({ "n", "v" }, "<leader>ci", ":CodeCompanion<cr>", { desc = "Inline chat" })
  end,
}
