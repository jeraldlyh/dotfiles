local send_enter_key = function(delay)
  local pane = vim.env.TMUX_PANE

  if not pane or pane == "" then
    vim.notify("TMUX_PANE not set", vim.log.levels.ERROR)
    return
  end

  vim.defer_fn(function()
    vim.fn.system({
      "tmux",
      "send-keys",
      "-t",
      vim.env.TMUX_PANE,
      "Enter",
    })
  end, delay or 100)
end

local save_chat = function()
  local save_dir = vim.fn.expand("$HOME/Documents/Personal/ai/sidekick-chat")
  vim.fn.mkdir(save_dir, "p")

  local filename = save_dir .. "/" .. os.date("%Y-%m-%d_%H-%M-%S") .. ".md"

  require("sidekick.cli").send({
    msg = "/share file " .. filename,
  })

  send_enter_key(100)
end

local start_new_chat = function()
  require("sidekick.cli").send({ msg = "/new" })

  send_enter_key(200)
end

return {
  "folke/sidekick.nvim",
  opts = {
    nes = {
      enabled = true,
    },
    cli = {
      mux = {
        backend = "tmux",
        enabled = true,
      },
    },
  },
  keys = {
    {
      "<M-Enter>",
      function()
        if not require("sidekick").nes_jump_or_apply() then
          return "<M-Enter>"
        end
      end,
      expr = true,
      desc = "Goto/apply next edit suggestion",
    },
    {
      "<leader>cn",
      function()
        save_chat()
        start_new_chat()
      end,
      mode = { "n", "x" },
      desc = "Start new chat",
    },
    {
      "<leader>cc",
      function()
        save_chat()
        start_new_chat()

        vim.defer_fn(function()
          require("sidekick.cli").close()
        end, 300)
      end,
      desc = "Close and save chat",
    },
    {
      "<leader>cl",
      function()
        require("sidekick.cli").send({ msg = "{this}" })
      end,
      mode = { "x", "n" },
      desc = "Add current line to chat",
    },
    {
      "<leader>cf",
      function()
        require("sidekick.cli").send({ msg = "{file}" })
      end,
      desc = "Add file to chat",
    },
    {
      "<leader>cp",
      function()
        require("sidekick.cli").prompt()
      end,
      mode = { "n", "x" },
      desc = "Sidekick Select Prompt",
    },
    {
      "<leader>co",
      function()
        require("sidekick.cli").toggle({ name = "copilot", focus = true })
      end,
      desc = "Toggle AI chat",
    },
    {
      "<leader>ca",
      function()
        require("sidekick.cli").send({ msg = "{selection}" })
      end,
      mode = { "x" },
      desc = "Add visual selection to chat",
    },
  },
}
