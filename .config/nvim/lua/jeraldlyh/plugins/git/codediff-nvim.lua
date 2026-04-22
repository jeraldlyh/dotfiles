return {
  "esmuellert/codediff.nvim",
  cmd = "CodeDiff",
  keys = {
    {
      "<leader>gD",
      "<cmd>CodeDiff main<cr>",
      desc = "View diff with main",
    },
    {
      "<leader>gd",
      "<cmd>CodeDiff<cr>",
      desc = "View diff",
    },
    {
      "<leader>gh",
      "<cmd>CodeDiff HEAD<cr>",
      desc = "View diff with HEAD",
    },
    {
      "<leader>gH",
      "<cmd>CodeDiff history<cr>",
      desc = "View git history",
    },
  },
  opts = {
    explorer = {
      view_mode = "tree",
    },
    keymaps = {
      view = {
        quit = "q",
        next_hunk = "J",
        prev_hunk = "K",
        next_file = "<Right>",
        prev_file = "<Left>",
        toggle_stage = "a",
      },
      history = {
        select = "<CR>",
        toggle_view_mode = "i",
      },
    },
  },
  config = function(_, opts)
    require("codediff").setup(opts)

    -- NOTE: Workaround for keymaps not restoring after closing diff view
    --      https://github.com/esmuellert/codediff.nvim/issues/289
    vim.api.nvim_create_autocmd("User", {
      pattern = "CodeDiffClose",
      callback = function(event)
        vim.keymap.set(
          "n",
          "K",
          vim.lsp.buf.hover,
          { buffer = event.buf, silent = true, desc = "Show documentation for what is under cursor" }
        )
      end,
    })
  end,
}
