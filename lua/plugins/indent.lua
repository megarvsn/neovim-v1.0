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