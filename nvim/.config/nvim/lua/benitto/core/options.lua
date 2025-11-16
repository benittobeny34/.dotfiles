vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

opt.relativenumber = true
opt.number = true
opt.laststatus = 4

--Tabs & Indentation
opt.tabstop = 4 --4 spaces for tabs
opt.shiftwidth = 4 -- 4 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

opt.wrap = true
opt.textwidth = 80
opt.colorcolumn = "81" -- highlight the 81th column

--Search Settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = false -- if you incluse mixed case in your search , asumes you want case-sensitive

--turn on termguicolors for tokonight colorschem to work
-- (have touse iterm2 or any other true color termimal)
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- Eye comfort settings for extended coding sessions
opt.cursorline = true -- highlight current line for better focus
opt.scrolloff = 8 -- keep 8 lines above/below cursor for context
opt.sidescrolloff = 8 -- keep 8 columns left/right of cursor
opt.updatetime = 250 -- faster completion and updates (default 4000ms)
opt.timeoutlen = 300 -- faster key sequence completion

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

--clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

--split windows
opt.splitright = true -- split vertical windw to the right
opt.splitbelow = true -- split horizontal windw to the bottom

-- In order to work below command php-cs-fixer must be installed in our system
vim.api.nvim_create_user_command("FixPHP", function()
	local file_path = vim.fn.expand("%:p") -- Get the full path of the current file
	vim.cmd("!php-cs-fixer fix " .. file_path .. " --dry-run") -- Run php-cs-fixer on the current file
end, {})

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight whenyanking (copying) text",
	group = vim.api.nvim_create_augroup("hightligh-on-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_user_command("Conflicts", function()
	vim.cmd("Gvdiffsplit!") -- triggers Fugitive merge tool for current file
end, { desc = "Open current file in Fugitive mergetool" })
-- vim.api.nvim_create_autocmd("TermOpen", {
-- 	group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
-- 	callback = function()
-- 		vim.opt.number = false
-- 		vim.opt.relativenumber = false
-- 	end,
-- })
