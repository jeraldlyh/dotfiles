return {
  "aaronhallaert/advanced-git-search.nvim",
  config = function()
    require("telescope").setup({
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
    require("telescope").load_extension("advanced_git_search")
  end,
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "tpope/vim-fugitive",
    "tpope/vim-rhubarb",
  },
}
