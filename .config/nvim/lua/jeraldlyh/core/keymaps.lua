vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
keymap.set("n", "<leader>nh", ":nohl<cr>", { desc = "Clear search highlights" })
keymap.set("n", "<C-q>", ":q<cr>", { desc = "Quit" })

-- window
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<cr>", { desc = "Close current split" })

-- tabs
keymap.set("n", "<leader>to", "<cmd>tabnew<cr>", { desc = "Open new tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<cr>", { desc = "Close current tab" })
keymap.set("n", "<leader>tn", "<cmd>tabn<cr>", { desc = "Go to next tab" })
keymap.set("n", "<leader>tp", "<cmd>tabp<cr>", { desc = "Go to previous tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<cr>", { desc = "Open current buffer in new tab" })

-- typescript-tools.nvim
-- keymap.set("n", "<leader>oi", "<cmd>TSToolsOrganizeImports<cr>", { desc = "Organize imports" })
-- keymap.set("n", "<leader>fa", "<cmd>TSToolsFixAll<cr>", { desc = "Fix all" })

-- package
keymap.set("n", "<leader>pl", "<cmd>Lazy install<cr>", { desc = "Open Lazy" })
keymap.set("n", "<leader>pm", "<cmd>Mason<cr>", { desc = "Open Mason" })

-- session
keymap.set("n", "<leader>wr", "<cmd>SessionRestore<CR>", { desc = "Restore session for cwd" })
keymap.set("n", "<leader>ws", "<cmd>SessionSave<CR>", { desc = "Save session for auto session root dir" })

-- comment divider
keymap.set("n", "<leader>cb", "<cmd>CommentDividerBox<cr>", { desc = "Comment box" })

-- formatting
keymap.set({ "n", "v" }, "<leader>mp", function()
  require("conform").format({
    lsp_fallback = true,
    async = false,
    timeout_ms = 1000,
  })
end, { desc = "Format file or range (in visual mode)" })

-- git
keymap.set("n", "<leader>gg", "<cmd>LazyGit<cr>", { desc = "Open Lazy git" })
keymap.set("n", "g1", "<cmd>Gitsign prev_hunk<cr>", { desc = "Next hunk" })
keymap.set("n", "g2", "<cmd>Gitsign next_hunk<cr>", { desc = "Previous hunk" })
keymap.set("n", "<leader>gd", "<cmd>Gitsign diffthis<cr>", { desc = "View diff" })

-- advanced git search
keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", { desc = "Branches" })
keymap.set("n", "<leader>gc", "<cmd>AdvancedGitSearch search_log_content<cr>", { desc = "Commits (repo)" })
keymap.set("n", "<leader>gC", "<cmd>AdvancedGitSearch search_log_content_file<cr>", { desc = "Commits (file)" })
keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>", { desc = "Git status" })
keymap.set("n", "<leader>gB", "<cmd>Gitsigns toggle_current_line_blame<cr>", { desc = "Toggle blame" })
keymap.set({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<cr>", { desc = "Gitsigns select hunk" })

-- telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files in directory" })
keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Find recent files" })
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find word" })
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in directory" })
keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Find keymaps" })
keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
keymap.set("v", "<leader>f", function()
  function vim.getVisualSelection()
    vim.cmd('noau normal! "vy"')
    local text = vim.fn.getreg("v")
    vim.fn.setreg("v", {})

    text = string.gsub(text, "\n", "")
    if #text > 0 then
      return text
    else
      return ""
    end
  end

  local text = vim.getVisualSelection()
  require("telescope.builtin").live_grep({ default_text = text })
end, { desc = "Find word in selection" })

-- move
keymap.set("n", "<S-Up>", ":MoveLine(-1)<cr>", { desc = "Move line up" })
keymap.set("n", "<S-Down>", ":MoveLine(1)<cr>", { desc = "Move line down" })
keymap.set("i", "<S-Up>", "<Esc>:m .-2<CR>==gi", { desc = "Move line up" })
keymap.set("i", "<S-Down>", "<Esc>:m .+1<CR>==gi", { desc = "Move line down" })
keymap.set("v", "<S-Up>", ":MoveBlock(-1)<CR>", { desc = "Move block up" })
keymap.set("v", "<S-Down>", ":MoveBlock(1)<CR>", { desc = "Move block down" })
