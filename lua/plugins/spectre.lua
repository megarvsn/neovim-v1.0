-- ПЛАГИН: nvim-spectre (https://github.com/nvim-pack/nvim-spectre)
-- Массовая замена текста по всему проекту с превью каждой замены
-- и выбором, где применять. Для замены классов/текстов, когда LSP-переименование
-- не подходит (обычный текст, html-атрибуты, css-классы).
return {
	"nvim-pack/nvim-spectre",
	dependencies = { "nvim-lua/plenary.nvim" },
	lazy = true,
	keys = {
		{ "<leader>fs", function() require("spectre").open() end, desc = "Замена по проекту (Spectre)" },
		{ "<leader>fS", function() require("spectre").open_file_search() end, desc = "Замена в текущем файле" },
		{ "<leader>fs", mode = "x", function() require("spectre").open_visual({ select_word = true }) end,
			desc = "Замена выделенного по проекту" },
	},
}