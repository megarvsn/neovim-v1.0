return {
	{
		"folke/trouble.nvim",
		opts = {}, --for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
		keys = {
			{
				"<leader>qq",
				"<cmd>Trouble diagnostics toggle focus=true<cr>",
				desc = "Все ошибки проекта",
			},
			{
				"<leader>qQ",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Ошибки текущего файла",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Функции и переменные файла",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "Определения и ссылки символа",
			},
			{
				"<leader>qL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Список текущего окна",
			},
			{
				"<leader>qf",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix-список",
			},
		},
	}
}