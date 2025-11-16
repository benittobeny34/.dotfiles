return {
	"folke/tokyonight.nvim",
	priority = 1000,
	config = function()
		-- Optimized for 8+ hour coding sessions - warmer tones, reduced blue light
		local colors = {
			-- Warmer, softer backgrounds to reduce eye strain
			bg = "#24283b", -- slightly warmer dark blue (tokyonight storm base)
			bg_dark = "#1a1e2e", -- deeper, warmer background
			bg_highlight = "#414868", -- softer highlight with less contrast
			bg_search = "#7aa2f7", -- clear but not harsh search
			bg_visual = "#364A82", -- comfortable visual selection

			-- Warmer foreground colors
			fg = "#c0caf5", -- brighter but warmer text (easier to read)
			fg_dark = "#7982a9", -- muted for inactive elements
			fg_gutter = "#3b4261", -- subtle line numbers
			border = "#414868", -- clear but soft borders

			-- Softer syntax colors to reduce eye strain
			comment = "#565f89", -- readable comments without being too bright
			cyan = "#7dcfff", -- reduced blue light in cyan
			green = "#9ece6a", -- warm green for strings
			orange = "#ff9e64", -- warm orange for constants
			yellow = "#e0af68", -- softer yellow for warnings
			purple = "#bb9af7", -- lavender purple (less harsh than pure purple)
			magenta = "#c678dd", -- soft magenta for keywords
		}

		require("tokyonight").setup({
			style = "storm", -- storm is warmer than night
			light_style = "day",
			transparent = false, -- set to true if you use transparent terminal
			terminal_colors = true,
			styles = {
				comments = { italic = true },
				keywords = { italic = true, bold = false },
				functions = { bold = false },
				variables = {},
				sidebars = "dark",
				floats = "dark",
			},
			sidebars = { "qf", "help", "vista_kind", "terminal", "packer" },
			day_brightness = 0.3,
			hide_inactive_statusline = false,
			dim_inactive = true, -- dims inactive windows for better focus
			lualine_bold = false, -- less bold = easier on eyes

			on_colors = function(c)
				-- Apply our custom warmer color palette
				c.bg = colors.bg
				c.bg_dark = colors.bg_dark
				c.bg_float = colors.bg_dark
				c.bg_highlight = colors.bg_highlight
				c.bg_popup = colors.bg_dark
				c.bg_search = colors.bg_search
				c.bg_sidebar = colors.bg_dark
				c.bg_statusline = colors.bg_dark
				c.bg_visual = colors.bg_visual
				c.border = colors.border
				c.fg = colors.fg
				c.fg_dark = colors.fg_dark
				c.fg_float = colors.fg
				c.fg_gutter = colors.fg_gutter
				c.fg_sidebar = colors.fg_dark
				c.comment = colors.comment
				c.cyan = colors.cyan
				c.green = colors.green
				c.orange = colors.orange
				c.yellow = colors.yellow
				c.purple = colors.purple
				c.magenta = colors.magenta
			end,

			on_highlights = function(hl, c)
				-- Further customization for long coding sessions
				hl.CursorLine = { bg = c.bg_highlight }
				hl.CursorLineNr = { fg = colors.orange, bold = true }
				hl.LineNr = { fg = colors.fg_gutter }

				-- Softer diagnostics to reduce visual noise
				hl.DiagnosticError = { fg = "#f7768e" }
				hl.DiagnosticWarn = { fg = colors.yellow }
				hl.DiagnosticInfo = { fg = colors.cyan }
				hl.DiagnosticHint = { fg = colors.green }

				-- Better contrast for important elements
				hl.Function = { fg = colors.cyan }
				hl.String = { fg = colors.green }
				hl.Keyword = { fg = colors.magenta, italic = true }
				hl.Type = { fg = colors.cyan }
				hl.Constant = { fg = colors.orange }
			end,
		})

		vim.cmd("colorscheme tokyonight")
	end,
}
