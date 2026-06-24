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
      initial_focus = "modified",
    },
    diff = {
      cycle_hunks_across_files = true,
    },
    keymaps = {
      view = {
        toggle_explorer = "<leader>e",
        focus_explorer = "<leader>E",
        quit = "q",
        next_file = "<Right>",
        prev_file = "<Left>",
        toggle_stage = "a",
        stage_hunk = "<leader>gs",
        unstage_hunk = "<leader>gu",
        open_in_prev_tab = "gf",
        close_on_open_in_prev_tab = true,
      },
      explorer = {
        restore = "d",
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
