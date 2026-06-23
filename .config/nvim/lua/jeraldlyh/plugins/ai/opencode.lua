return {
  "sudo-tee/opencode.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "folke/snacks.nvim",
  },
  config = function()
    require("opencode").setup({
      preferred_picker = "snacks",
      default_global_keymaps = false,
      ui = {
        icons = {
          position = "right",
        },
      },
      context = {
        enabled = true,
        cursor_data = {
          enabled = false,
          context_lines = 5,
        },
        diagnostics = {
          info = false,
          warning = true,
          error = true,
          only_closest = false,
        },
        current_file = {
          enabled = true,
          show_full_path = true,
        },
        files = {
          enabled = true,
          show_full_path = true,
        },
        selection = {
          enabled = true,
        },
        buffer = {
          enabled = false,
        },
        git_diff = {
          enabled = false,
        },
      },
      keymap = {
        editor = {
          ["<leader>co"] = { "toggle", desc = "Toggle opencode" },
          ["<leader>cf"] = { "timeline", desc = "Show timeline" },
          ["<leader>cs"] = { "select_session", desc = "Select session" },
          ["<leader>cp"] = { "configure_provider", desc = "Configure provider" },
          ["<leader>cv"] = { "configure_variant", desc = "Configure variant" },
          ["<leader>ca"] = { "add_visual_selection", mode = { "v" }, desc = "Add visual selection" },
        },
        input_window = {
          ["<esc>"] = { "close", defer_to_completion = true },
          ["<C-c>"] = { "cancel", defer_to_completion = true },
          ["~"] = { "mention_file", mode = "i" },
          ["@"] = { "mention", mode = "i" },
          ["/"] = { "slash_commands", mode = "i" },
          ["#"] = { "context_items", mode = "i" },
          ["<C-v>"] = { "paste_image", mode = "i" },
          ["<up>"] = { "prev_prompt_history", mode = { "n", "i" }, defer_to_completion = true },
          ["<down>"] = { "next_prompt_history", mode = { "n", "i" }, defer_to_completion = true },
          ["<right>"] = { "cycle_variant", mode = { "n", "i" } },
          ["<tab>"] = { "switch_mode" },
        },
      },
    })

    local save_chat = function()
      local save_dir = vim.fn.expand("$HOME/Documents/Personal/ai/opencode-chat")
      vim.fn.mkdir(save_dir, "p")

      local session = require("opencode.state").active_session
      if not session then
        vim.notify("No active opencode session", vim.log.levels.WARN, { title = "opencode" })
        return
      end

      local safe_title = (session.title or "untitled"):gsub("[^%w%-%s]", "_"):sub(1, 40)
      local filename = save_dir .. "/" .. os.date("%Y-%m-%d_%H-%M-%S") .. "_" .. safe_title .. ".json"

      vim.fn.jobstart({ "opencode", "export", session.id }, {
        stdout_buffered = true,
        on_stdout = function(_, data)
          if data and #data > 0 then
            local content = table.concat(data, "\n")
            local file = io.open(filename, "w")
            if file then
              file:write(content)
              file:close()
              vim.notify("Saved: " .. vim.fn.fnamemodify(filename, ":t"), vim.log.levels.INFO, { title = "opencode" })
            end
          end
        end,
      })
    end

    local start_new_chat = function()
      require("opencode.api").open_input_new_session()
    end

    local implement_issue = function()
      vim.ui.input({ prompt = "GitHub/GitLab issue URL: " }, function(url)
        if not url or url == "" then
          vim.notify("No URL provided", vim.log.levels.WARN, { title = "opencode" })
          return
        end

        local prompt = "Use 'gh' or 'glab' cli and refer to the following issue and implement the solution in the current repository. Do not commit any code using the CLI.\n\n"
          .. "1. Read the issue description, comments, and any proposed solution in full.\n"
          .. "2. Explore the current repository to understand the relevant code, architecture, and conventions.\n"
          .. "3. Evaluate the proposed solution (if any):\n"
          .. "   - If a clearly better or improved solution exists, describe it concisely, explain why it is better, and wait for confirmation before writing any code.\n"
          .. "   - If the proposed solution is already sound, implement it directly without prompting.\n"
          .. "4. Follow the existing code style and conventions in this repository.\n\n"
          .. url
        require("opencode.api").open_input()

        vim.schedule(function()
          require("opencode.ui.input_window").set_content(prompt)
        end)
      end)
    end

    local keymap = vim.keymap

    keymap.set({ "n", "x" }, "<leader>ci", implement_issue, { desc = "Implement GitHub/GitLab issue" })
    keymap.set({ "n", "x" }, "<leader>cn", function()
      save_chat()
      vim.defer_fn(start_new_chat, 500)
    end, { desc = "Save and start new opencode chat" })
  end,
}
