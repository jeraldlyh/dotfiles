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
keymap.set("n", "<leader>pM", "<cmd>Mason<cr>", { desc = "Open Mason" })

-- session
keymap.set("n", "<leader>wr", "<cmd>SessionRestore<cr>", { desc = "Restore session for cwd" })
keymap.set("n", "<leader>ws", "<cmd>SessionSave<cr>", { desc = "Save session for auto session root dir" })

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
keymap.set("n", "g3", "<cmd>Gitsigns prev_hunk<cr>", { desc = "Next hunk" })
keymap.set("n", "g4", "<cmd>Gitsigns next_hunk<cr>", { desc = "Previous hunk" })
keymap.set("n", "<leader>gg", "<cmd>LazyGit<cr>", { desc = "Open Lazy git" })
keymap.set("n", "<leader>gd", "<cmd>Gitsign diffthis<cr>", { desc = "View diff" })
keymap.set("n", "<leader>gD", "<cmd>Gitsign diffthis ~<cr>", { desc = "View diff (~)" })
keymap.set("n", "<leader>gB", "<cmd>Gitsign toggle_current_line_blame<cr>", { desc = "Toggle blame" })
keymap.set("n", "<leader>gb", "<cmd>Gitsign blame_line {full = true}<cr>", { desc = "Blame line" })
keymap.set("n", "<leader>gs", function()
  require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
end, { desc = "Stage hunk" })
keymap.set("n", "<leader>gr", function()
  require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
end, { desc = "Reset hunk" })
keymap.set("n", "<leader>gS", "<cmd>Gitsign stage_buffer<cr>", { desc = "Stage buffer" })
keymap.set("n", "<leader>gR", "<cmd>Gitsign reset_buffer<cr>", { desc = "Reset buffer" })
keymap.set("n", "<leader>gu", "<cmd>Gitsign undo_stage_hunk<cr>", { desc = "Undo stage hunk" })
keymap.set("n", "<leader>gp", "<cmd>Gitsign preview_hunk<cr>", { desc = "Preview hunk" })

-- advanced git search
keymap.set({ "o", "x" }, "ih", ":<C-U>Gitsign select_hunk<cr>", { desc = "Gitsigns select hunk" })

-- telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Find recent files" })
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find word" })
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor" })
keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Find keymaps" })
keymap.set("n", "<leader>fn", "<cmd>Noice history<cr>", { desc = "Find notification history" })
keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
keymap.set("n", "<leader>fb", "<cmd>Telescope git_branches<cr>", { desc = "Branches" })
keymap.set("n", "<leader>fc", "<cmd>AdvancedGitSearch search_log_content<cr>", { desc = "Commits (repo)" })
keymap.set("n", "<leader>fC", "<cmd>AdvancedGitSearch search_log_content_file<cr>", { desc = "Commits (file)" })
keymap.set("n", "<leader>fS", "<cmd>Telescope git_status<cr>", { desc = "Git status" })
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
keymap.set("i", "<S-Up>", "<Esc>:m .-2<cr>==gi", { desc = "Move line up" })
keymap.set("i", "<S-Down>", "<Esc>:m .+1<cr>==gi", { desc = "Move line down" })
keymap.set("v", "<S-Up>", ":MoveBlock(-1)<cr>", { desc = "Move block up" })
keymap.set("v", "<S-Down>", ":MoveBlock(1)<cr>", { desc = "Move block down" })
keymap.set("n", "g1", function()
  vim.diagnostic.goto_prev()
end, { desc = "Prev problem" })
keymap.set("n", "g2", function()
  vim.diagnostic.goto_next()
end, { desc = "Next problem" })

-- notifications
keymap.set("n", "<leader>nc", "<cmd>Noice dismiss<cr>", { desc = "Close all notifications" })

-- harpoon
keymap.set("n", "<leader>ha", function()
  require("harpoon"):list():add()
end, { desc = "Add harpoon" })
keymap.set("n", "<leader>ho", function()
  local harpoon = require("harpoon")

  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Open harpoons" })

keymap.set("n", "<leader>1", function()
  require("harpoon"):list():select(1)
end, { desc = "Go to harpoon 1" })
keymap.set("n", "<leader>2", function()
  require("harpoon"):list():select(2)
end, { desc = "Go to harpoon 2" })
keymap.set("n", "<leader>3", function()
  require("harpoon"):list():select(3)
end, { desc = "Go to harpoon 3" })
keymap.set("n", "<leader>4", function()
  require("harpoon"):list():select(4)
end, { desc = "Go to harpoon 4" })

keymap.set("n", "<C-S-P>", function()
  require("harpoon"):list():prev()
end, { desc = "Go to previous mark" })
keymap.set("n", "<C-S-N>", function()
  require("harpoon"):list():next()
end, { desc = "Go to next mark" })

-- file explorer
keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle file explorer" })
keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<cr>", { desc = "Toggle file explorer on current file" })
keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<cr>", { desc = "Collapse file explorer" })
keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<cr>", { desc = "Refresh file explorer" })

-- cold folding
keymap.set("n", "zR", function()
  require("ufo").openAllFolds()
end, { desc = "Open all folds" })
keymap.set("n", "zM", function()
  require("ufo").closeAllFolds()
end, { desc = "Close all folds" })
keymap.set("n", "zK", function()
  local winId = require("ufo").peekFoldedLinesUnderCursor()

  if not winId then
    vim.lsp.buf.hover()
  end
end, { desc = "Peek fold" })

-- utils
keymap.set("n", "<leader>rl", "<cmd>set rnu!<cr>", { desc = "Toggle relative line numbers" })
keymap.set("n", "<leader>as", "<cmd>ASToggle<cr>", { desc = "Toggle auto save" })
keymap.set(
  "n",
  "<leader>rb",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "Replace word in buffer" }
)
