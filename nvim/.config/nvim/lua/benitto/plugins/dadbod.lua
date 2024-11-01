return {
	"tpope/vim-dadbod",
	dependencies = {
		"kristijanhusak/vim-dadbod-completion",
		"kristijanhusak/vim-dadbod-ui",
	},

	config = function()
		-- SQL specific completion setup in nvim-cmp
		local cmp = require("cmp")
		cmp.setup.filetype("mysql", {
			sources = cmp.config.sources({
				{ name = "vim-dadbod-completion" }, -- Database completion
				{ name = "buffer" }, -- Buffer completion
				{ name = "path" }, -- Path completion
			}),
		})

		-- Key mappings for vim-dadbod-ui
		vim.api.nvim_set_keymap("n", "<leader>db", ":tabnew | :DBUI<CR>", { noremap = true, silent = true })
		vim.api.nvim_set_keymap("n", "<leader>dbt", ":DBUIToggle<CR>", { noremap = true, silent = true })
		vim.api.nvim_set_keymap("n", "<leader>dbf", ":DBUIFindBuffer<CR>", { noremap = true, silent = true })
		vim.api.nvim_set_keymap("n", "<leader>dbn", ":DBUIRenameBuffer<CR>", { noremap = true, silent = true })
	end,
}
