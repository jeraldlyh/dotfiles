vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
keymap.set("n", "<leader>nh", ":nohl<cr>", { desc = "Clear search highlights" })
keymap.set("n", "<C-q>", ":q<cr>", { desc = "Quit" })

-- black hole registers
keymap.set({ "n", "v" }, "x", '"_x')
keymap.set({ "n", "v" }, "X", '"_X')
keymap.set({ "n", "v" }, "d", '"_d')
keymap.set({ "n", "v" }, "D", '"_D')
keymap.set({ "n", "v" }, "c", '"_c')
keymap.set({ "n", "v" }, "C", '"_C')
keymap.set("x", "p", '"_dP') -- paste without overwriting the default register

-- window
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sH", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<cr>", { desc = "Close current split" })
keymap.set("n", "<leader>sl", "<cmd>vertical resize -5<cr>", { desc = "Decrease width" })
keymap.set("n", "<leader>sh", "<cmd>vertical resize +5<cr>", { desc = "Increase width" })
keymap.set("n", "<leader>sj", "<cmd>resize +5<cr>", { desc = "Increase height" })
keymap.set("n", "<leader>sk", "<cmd>resize -5<cr>", { desc = "Decrease height" })
keymap.set("n", "<C-e>", "3<C-e>", { desc = "Scroll down" })
keymap.set("n", "<C-y>", "3<C-y>", { desc = "Scroll up" })

-- tabs
keymap.set("n", "<leader>to", "<cmd>tabnew<cr>", { desc = "Open new tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<cr>", { desc = "Close current tab" })
keymap.set("n", "<leader>tn", "<cmd>tabn<cr>", { desc = "Go to next tab" })
keymap.set("n", "<leader>tp", "<cmd>tabp<cr>", { desc = "Go to previous tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<cr>", { desc = "Open current buffer in new tab" })

-- package
keymap.set("n", "<leader>pl", "<cmd>Lazy install<cr>", { desc = "Open Lazy" })
keymap.set("n", "<leader>pM", "<cmd>Mason<cr>", { desc = "Open Mason" })

-- diagnostics
keymap.set("n", "g1", function()
  vim.diagnostic.goto_prev()
end, { desc = "Prev problem" })
keymap.set("n", "g2", function()
  vim.diagnostic.goto_next()
end, { desc = "Next problem" })

-- utils
keymap.set("n", "<leader>fm", "<cmd>messages<cr>", { desc = "Find messages" })
keymap.set("n", "<leader>sa", "gg<S-v>G", { desc = "Select all" })
keymap.set("n", "<leader>rl", "<cmd>set rnu!<cr>", { desc = "Toggle relative line numbers" })
-- keymap.set("n", "<leader>rf", function()
--   if vim.g.disable_autoformat then
--     vim.g.disable_autoformat = false
--   else
--     vim.g.disable_autoformat = true
--   end
-- end, { desc = "Toggle save on format" })

keymap.set("n", "pi", function()
  local char = vim.fn.getcharstr()
  local motion = "i" .. char

  vim.cmd("normal! v" .. motion .. '"0p')
end, { desc = "Paste inside object (word, quotes, etc.)" })
