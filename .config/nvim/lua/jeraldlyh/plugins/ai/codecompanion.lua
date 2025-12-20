return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "folke/snacks.nvim",
    "neovim/nvim-lspconfig",
    "ravitemer/codecompanion-history.nvim",
    "MeanderingProgrammer/render-markdown.nvim",
  },
  config = function()
    local codecompanion = require("codecompanion")
    local keymap = vim.keymap
    local providers = require("codecompanion.providers")

    codecompanion.setup({
      adapters = {
        http = {
          opts = {
            allow_insecure = vim.env.COPILOT_PROXY_SERVER ~= nil,
            proxy = vim.env.COPILOT_PROXY_SERVER or nil,
            show_model_choices = true,
          },
        },
      },
      strategies = {
        chat = { adapter = "copilot", model = "gpt-4o" },
        inline = {
          adapter = "copilot",
          keymaps = {
            accept_change = {
              modes = { n = "ga" },
              description = "Accept the suggested change",
            },
            reject_change = {
              modes = { n = "gr" },
              opts = { nowait = true },
              description = "Reject the suggested change",
            },
          },
        },
      },
      display = {
        chat = {
          window = {
            width = 0.3,
          },
        },
        diff = {
          enabled = true,
          provider = providers.diff,
          provider_opts = {
            inline = {
              layout = "buffer",
              diff_signs = {
                signs = {
                  text = "▌",
                  reject = "✗",
                  highlight_groups = {
                    addition = "DiagnosticOk",
                    deletion = "DiagnosticError",
                    modification = "DiagnosticWarn",
                  },
                },
                icons = {
                  accepted = " ",
                  rejected = " ",
                },
                colors = {
                  accepted = "DiagnosticOk",
                  rejected = "DiagnosticError",
                },
              },
              opts = {
                context_lines = 3,
                dim = 25,
                full_width_removed = true,
                show_keymap_hints = true,
                show_removed = true,
              },
            },
            split = {
              close_chat_at = 240,
              layout = "vertical",
              opts = {
                "internal",
                "filler",
                "closeoff",
                "algorithm:histogram",
                "indent-heuristic",
                "followwrap",
                "linematch:120",
              },
            },
          },
        },
      },
      extensions = {
        vectorcode = {
          enabled = false,
        },
        history = {
          enabled = true,
          opts = {
            keymap = "gh",
            save_chat_keymap = "sc",
            auto_save = true,
            expiration_days = 0,
            picker = "snacks",
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
            dir_to_save = vim.fn.expand("$HOME/Documents/Personal/ai/codecompanion-chat"),
            enable_logging = false,
          },
          memory = {
            enabled = false,
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
    keymap.set("v", "<leader>ca", function()
      codecompanion.add({})
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
    end, { desc = "Add visual selected to chat" })
    keymap.set({ "n", "v" }, "<leader>ci", ":CodeCompanion<cr>", { desc = "Inline chat" })
  end,
}
