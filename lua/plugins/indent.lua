-- ПЛАГИН: indent-blankline.nvim (https://github.com/lukas-reineke/indent-blankline.nvim)
-- Вертикальные линии по уровням отступов: видно вложенность блоков.
-- Линии отступов: видно вложенность блоков в HTML/PHP/SCSS
return {
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			exclude = {
				filetypes = { "dashboard", "neo-tree", "toggleterm", "TelescopePrompt", "help" },
			},
		},
	},
}