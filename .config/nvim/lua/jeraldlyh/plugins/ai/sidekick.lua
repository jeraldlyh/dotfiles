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
      "<leader>cc",
      function()
        require("sidekick.cli").close()
      end,
      desc = "Detach a CLI Session",
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
