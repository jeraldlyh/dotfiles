return {
  "aaronhallaert/advanced-git-search.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "tpope/vim-fugitive",
    "tpope/vim-rhubarb",
  },
  config = function()
    local telescope = require("telescope")
    telescope.setup({
      extensions = {
        advanced_git_search = {
          browse_command = "GBrowse {commit_hash}",
          diff_plugin = "fugitive",
          git_flags = {},
          git_diff_flags = {},
          git_log_flags = {},
          show_builtin_git_pickers = false,
          entry_default_author_or_date = "author",
          keymaps = {
            toggle_date_author = "<C-w>",
            open_commit_in_browser = "<C-o>",
            copy_commit_hash = "<C-y>",
            show_entire_commit = "<C-e>",
          },
        },
      },
    })
    telescope.load_extension("advanced_git_search")

    vim.keymap.set("n", "<leader>fc", "<cmd>AdvancedGitSearch search_log_content<cr>", { desc = "Find commits (repo)" })
    vim.keymap.set(
      "n",
      "<leader>fC",
      "<cmd>AdvancedGitSearch search_log_content_file<cr>",
      { desc = "Find commits (file)" }
    )
  end,
}
