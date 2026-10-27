-- Цветовая тема Kanagawa (вариант wave) — тёплая палитра:
-- тёмно-бежевый фон, янтарные/оливковые/розовые акценты, умеренный контраст
return {
	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("kanagawa").setup({
				-- wave — основной тёплый вариант (альтернативы: dragon — темнее и спокойнее, lotus — светлая)
				theme = "wave",
				background = { dark = "wave", light = "lotus" },
				-- Непрозрачный фон
				transparent_background = false,
			})
			vim.cmd("colorscheme kanagawa")
		end,
	},
}