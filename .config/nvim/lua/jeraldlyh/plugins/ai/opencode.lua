return {
  "nickjvandyke/opencode.nvim",
  dependencies = {
    {
      ---@module "snacks"
      "folke/snacks.nvim",
      opts = {
        input = {},
        picker = {
          actions = {
            opencode_send = function(...)
              return require("opencode").snacks_picker_send(...)
            end,
          },
        },
      },
    },
  },
  config = function()
    local keymap = vim.keymap

    local opencode_cmd = "opencode --port"
    local snacks_terminal_opts = {
      win = {
        position = "right",
        enter = false,
      },
    }

    vim.g.opencode_opts = {
      server = {
        start = function()
          require("snacks.terminal").open(opencode_cmd, snacks_terminal_opts)
        end,
      },
    }
    vim.o.autoread = true

    local save_chat = function()
      local save_dir = vim.fn.expand("$HOME/Documents/Personal/ai/opencode-chat")
      vim.fn.mkdir(save_dir, "p")

      require("opencode.server.discovery")
        .get()
        :next(function(server)
          server:get_sessions():next(function(sessions)
            if not sessions or #sessions == 0 then
              vim.notify("No opencode sessions found", vim.log.levels.WARN, { title = "opencode" })
              return
            end

            local session = sessions[1]
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
                    vim.notify(
                      "Saved: " .. vim.fn.fnamemodify(filename, ":t"),
                      vim.log.levels.INFO,
                      { title = "opencode" }
                    )
                  end
                end
              end,
            })
          end)
        end)
        :catch(function(err)
          vim.notify("No opencode server: " .. (err or ""), vim.log.levels.ERROR, { title = "opencode" })
        end)
    end

    local start_new_chat = function()
      require("opencode").command("session.new")
    end

    local implement_issue = function()
      vim.ui.input({ prompt = "GitHub/GitLab issue URL: " }, function(url)
        if not url or url == "" then
          vim.notify("No URL provided", vim.log.levels.WARN, { title = "opencode" })
          return
        end
        require("opencode").prompt(
          "Use 'gh' or 'glab' cli and refer to the following issue and implement the solution in the current repository. Do not commit any code using the CLI.\n\n"
            .. "1. Read the issue description, comments, and any proposed solution in full.\n"
            .. "2. Explore the current repository to understand the relevant code, architecture, and conventions.\n"
            .. "3. Evaluate the proposed solution (if any):\n"
            .. "   - If a clearly better or improved solution exists, describe it concisely, explain why it is better, and wait for confirmation before writing any code.\n"
            .. "   - If the proposed solution is already sound, implement it directly without prompting.\n"
            .. "4. Follow the existing code style and conventions in this repository.\n\n"
            .. url
            .. " "
        )
      end)
    end

    keymap.set({ "n", "x" }, "<leader>cp", function()
      require("opencode").select()
    end, { desc = "Find opencode actions" })
    vim.keymap.set({ "n" }, "<leader>co", function()
      require("snacks.terminal").toggle(opencode_cmd, snacks_terminal_opts)
    end, { desc = "Toggle opencode" })
    keymap.set({ "n", "x" }, "<leader>ca", function()
      return require("opencode").operator("@this ")
    end, { desc = "Add range to opencode", expr = true })
    keymap.set({ "n", "x" }, "<leader>ci", implement_issue, { desc = "Implement GitHub/GitLab issue" })
    keymap.set({ "n", "x" }, "<leader>cn", function()
      save_chat()
      vim.defer_fn(start_new_chat, 500)
    end, { desc = "Save and start new opencode chat" })
    keymap.set({ "n", "x" }, "<leader>cc", function()
      save_chat()
      vim.defer_fn(function()
        require("opencode").toggle()
      end, 500)
    end, { desc = "Save and close opencode chat" })
    keymap.set({ "n" }, "<leader>cu", function()
      require("opencode").command("session.half.page.up")
    end, { desc = "Scroll opencode up" })
    keymap.set({ "n" }, "<leader>cd", function()
      require("opencode").command("session.half.page.down")
    end, { desc = "Scroll opencode down" })
  end,
}
