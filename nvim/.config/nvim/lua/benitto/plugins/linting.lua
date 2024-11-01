local function get_phpcs_config()
	-- Define a list of common PHP CS Fixer config filenames
	local config_files = { "phpcs.xml", "phpcs.xml.dist", ".phpcs.xml", ".phpcs.xml.dist" }

	-- Loop through the list of config files
	for _, config in ipairs(config_files) do
		-- Use Neovim's `findfile` function to search for the config file
		-- This will search from the current directory upwards
		local config_path = vim.fn.findfile(config, ".;")

		-- If a config file is found, return its path
		if config_path and config_path ~= "" then
			return config_path
		end
	end

	-- Return nil if no config file is found
	return nil
end

return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			typescriptreact = { "eslint_d" },
			svelte = { "eslint_d" },
			python = { "pylint" },
			php = { "phpcs" },
			sh = { "shellcheck" },
			sql = { "sqlfluff" },
		}

		lint.linters.phpcs.args = function()
			local custom_phpcs_config = get_phpcs_config()

			local args = {}
			if custom_phpcs_config then
				-- If a custom config file is found, use it
				table.insert(args, "--standard=" .. custom_phpcs_config)
			else
				-- Fallback to PSR-12 if no config file is found
				table.insert(args, "--standard=PSR12")
			end

			table.insert(args, "--report=full")
			table.insert(args, "--encoding=utf-8")
			table.insert(args, "$FILENAME") -- Use the current file as input

			return args -- Ensure this returns an array of strings
		end

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})

		vim.keymap.set("n", "<leader>l", function()
			lint.try_lint()
		end, { desc = "Trigger linting for current file" })
	end,
}
