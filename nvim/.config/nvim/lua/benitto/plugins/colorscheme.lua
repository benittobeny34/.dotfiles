return {
	"folke/tokyonight.nvim",
	priority = 1000,
	config = function()
		local colors = {
			bg = "#292D3E", -- dark slate (background)
			bg_dark = "#1C1F2B", -- darker background
			bg_highlight = "#3E445E", -- for highlighting rows
			bg_search = "#676E95", -- for search background
			bg_visual = "#434758", -- visual selection
			fg = "#A6ACCD", -- base foreground
			fg_dark = "#676E95", -- inactive text
			fg_gutter = "#4B5263", -- line numbers
			border = "#3E445E", -- borders and split lines
		}

		require("tokyonight").setup({
			style = "storm",
			on_colors = function(c)
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
			end,
		})

		vim.cmd("colorscheme tokyonight")
	end,
}
