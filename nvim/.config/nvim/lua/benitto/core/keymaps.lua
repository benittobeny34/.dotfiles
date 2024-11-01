vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

--Increment / Decrement Numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment Number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement Number" })

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open a new tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "close current tab" })
keymap.set("n", "<c-]>", "<cmd>cnext<CR>", { desc = "Go to next QuickFix Entry" })
keymap.set("n", "<c-[>", "<cmd>cprev<CR>", { desc = "Go to prev QuickFix Entry" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })

-- Window Managment
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- Make split windows equal size
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close Current split" })
keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<CR>", { desc = "Open Undo tree toggle" })

--move line using visual mode
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move the line to below" })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move the line to above" })
