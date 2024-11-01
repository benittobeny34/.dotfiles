vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

opt.relativenumber = true
opt.number = true

--Tabs & Indentation
opt.tabstop = 4 --4 spaces for tabs
opt.shiftwidth = 4 -- 4 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

opt.wrap = false

--Search Settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you incluse mixed case in your search , asumes you want case-sensitive

--turn on termguicolors for tokonight colorschem to work
-- (have touse iterm2 or any other true color termimal)
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

--clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

--split windows
opt.splitright = true -- split vertical windw to the right
opt.splitbelow = true -- split horizontal windw to the bottom

--treate php files as html file as well so we can add html tags not yet confirmed whether it's working or not
-- vim.cmd([[
--   autocmd FileType php setlocal filetype=php.html
-- ]])
--
-- In order to work below command php-cs-fixer must be installed in our system
vim.api.nvim_create_user_command("FixPHP", function()
	local file_path = vim.fn.expand("%:p") -- Get the full path of the current file
	vim.cmd("!php-cs-fixer fix " .. file_path .. " --dry-run") -- Run php-cs-fixer on the current file
end, {})
