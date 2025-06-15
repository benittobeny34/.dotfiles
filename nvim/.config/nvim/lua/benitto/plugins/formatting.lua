local function get_php_cs_fixer_config()
	-- Define a list of common PHP CS Fixer config filenames
	local config_files = { ".php-cs-fixer.php", ".php_cs", ".php_cs.dist" }

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

	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				svelte = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				graphql = { "prettier" },
				liquid = { "prettier" },
				lua = { "stylua" },
				python = { "isort", "black" },
				sh = { "beautysh" },
				sql = { "sqlfmt" },
				mysql = { "sqlfmt" },
				psql = { "sqlfmt" }, -- PostgreSQL
				sqlite = { "sqlfmt" },
				go = { "gofmt" },
				php = {
					command = "php-cs-fixer",
					args = function()
						local args = { "fix", "$FILENAME" }
						local config_path = get_php_cs_fixer_config()

						vim.notify("Running php-cs-fixer with config: " .. (config_path or "no config found"))
						if config_path then
							table.insert(args, "--config=" .. config_path)
						end
						table.insert(args, "--allow-risky=yes")
						return args
					end,
					stdin = false,
				},
			},

			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
