return {
  "nickjvandyke/opencode.nvim",
  version = "v0.8.2",
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

    ---@type opencode.Opts
    vim.g.opencode_opts = {}
    vim.o.autoread = true

    local save_chat = function()
      local save_dir = vim.fn.expand("$HOME/Documents/Personal/ai/opencode-chat")
      vim.fn.mkdir(save_dir, "p")

      require("opencode.server")
        .get()
        :next(function(server)
          server:get_sessions(function(sessions)
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

    keymap.set({ "n", "x" }, "<leader>ca", function()
      require("opencode").ask("@this: ", { submit = true })
    end, { desc = "Ask opencode" })

    keymap.set({ "n", "x" }, "<leader>cp", function()
      require("opencode").select()
    end, { desc = "Execute opencode action" })
    keymap.set({ "n" }, "<leader>co", function()
      require("opencode").toggle()
    end, { desc = "Toggle opencode" })
    keymap.set({ "n", "x" }, "<leader>ca", function()
      return require("opencode").operator("@this ")
    end, { desc = "Add range to opencode", expr = true })

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
  end,
}
