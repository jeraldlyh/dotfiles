return {
  "christoomey/vim-tmux-navigator",
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
    "TmuxNavigatorProcessList",
  },
  init = function()
    local function set_keymaps()
      vim.keymap.set({ "n", "t", "v" }, "<C-h>", "<cmd>TmuxNavigateLeft<cr>")
      vim.keymap.set({ "n", "t", "v" }, "<C-j>", "<cmd>TmuxNavigateDown<cr>")
      vim.keymap.set({ "n", "t", "v" }, "<C-k>", "<cmd>TmuxNavigateUp<cr>")
      vim.keymap.set({ "n", "t", "v" }, "<C-l>", "<cmd>TmuxNavigateRight<cr>")
    end

    set_keymaps()

    vim.api.nvim_create_autocmd("TermEnter", {
      callback = set_keymaps,
    })
  end,
}
