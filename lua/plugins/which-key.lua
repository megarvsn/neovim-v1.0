return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		-- Русские названия групп — видны в подсказках при нажатии <leader>
		spec = {
			{ "<leader>f", group = "Поиск (Find)" },
			{ "<leader>g", group = "Git" },
			{ "<leader>d", group = "База данных" },
			{ "<leader>l", group = "LSP: код" },
			{ "<leader>q", group = "Панели" },
			{ "<leader>u", group = "Вид интерфейса" },

			-- Одиночные
			{ "<leader>e", desc = "Дерево файлов" },
			{ "<leader>w", desc = "Сохранить" },
			{ "<leader>x", desc = "Закрыть вкладку" },
			{ "<leader>?", desc = "Все клавиши буфера" },
		},
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Все клавиши текущего буфера",
		},
	},
}