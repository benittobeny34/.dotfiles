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

--delete & paste and preserve the previous yank
keymap.set("x", "<leader>p", '"_dP', { desc = "Delete and paste" })

keymap.set("n", "<leader>gm", ":G mergetool<CR>", { desc = "Open Gvdiffsplit for merge conflicts" })

-- Accept "ours" version (left) in merge
keymap.set("n", "<leader>co", ":diffget //2<CR>", { desc = "Accept Ours in merge" })
-- Accept "theirs" version (right) in merge
keymap.set("n", "<leader>ct", ":diffget //3<CR>", { desc = "Accept Theirs in merge" })

keymap.set("n", "<leader>cb", function()
	-- Yank theirs (right side) hunk
	vim.cmd("diffget //3")
	vim.cmd('normal! vip"ty') -- visually select hunk and yank
	vim.cmd("undo") -- undo back to ours
	vim.cmd("diffget //2") -- apply ours
	vim.cmd('normal! "tp') -- paste theirs after ours
	print("Merged both ours and theirs")
end, { desc = "Manually merge both ours and theirs" })

keymap.set("n", "<leader>gw", function()
	vim.cmd(":w")
	-- Turn off diff mode in all windows
	vim.cmd("diffoff!")

	-- Close all three windows
	vim.cmd("wincmd o") -- keep only the current window

	print("Saved and closed Gvdiffsplit")
end, { desc = "Mark current file resolved and stage" })

keymap.set("n", "<leader>gd", function()
	-- Discard changes in all diff buffers
	vim.cmd("silent! bufdo e!") -- reload all buffers, discarding unsaved changes

	-- Turn off diff mode in all windows
	vim.cmd("diffoff!")

	-- Close all three windows
	vim.cmd("wincmd o") -- keep only the current window

	print("Discarded all changes and closed Gvdiffsplit")
end, { desc = "Discard merge changes and close all Gvdiffsplit windows" })

keymap.set("n", "<leader>gn", function()
	local ok = pcall(vim.cmd, "/=======")
	if not ok then
		print("No more conflict separators found 👌")
	end
end, { desc = "Jump to next Git conflict separator =======" })
--open a new terminal at the bottom
-- keymap.set("n", "<leader>st", function()
-- 	vim.cmd.vnew()
-- 	vim.cmd.term()
-- 	vim.cmd.wincmd("J")
-- 	vim.api.nvim_win_set_height(0, 15)
-- end)
--
