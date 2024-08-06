vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
keymap.set("n", "<leader>nh", ":nohl<cr>", { desc = "Clear search highlights" })

keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

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
keymap.set("n", "<leader>oi", "<cmd>TSToolsOrganizeImports<cr>", { desc = "Organize imports" })
keymap.set("n", "<leader>fa", "<cmd>TSToolsFixAll<cr>", { desc = "Fix all" })

-- package
keymap.set("n", "<leader>pl", "<cmd>Lazy install<cr>", { desc = "Open Lazy" })
keymap.set("n", "<leader>pm", "<cmd>Mason<cr>", { desc = "Open Mason" })
