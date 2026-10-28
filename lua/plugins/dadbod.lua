-- ПЛАГИНЫ: vim-dadbod (https://github.com/tpope/vim-dadbod)
--          vim-dadbod-ui (https://github.com/kristijanhusak/vim-dadbod-ui)
--          vim-dadbod-completion (https://github.com/kristijanhusak/vim-dadbod-completion)
-- Доступ к MySQL с сервера: vim-dadbod + vim-dadbod-ui
-- Подключение через SSH-туннель: :SshTunnel 3306, затем <leader>db (см. lua/core/sshfs.lua)
return {
	{
		"tpope/vim-dadbod",
		lazy = true,
	},
	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = { "tpope/vim-dadbod" },
		lazy = true,
		keys = {
			{ "<leader>db", "<cmd>DBUI<cr>", desc = "Обзор базы (DBUI)" },
		},
		init = function()
			vim.g.db_ui_save_location = vim.fn.stdpath("data") .. "/db_ui"
			vim.g.db_ui_use_nerd_fonts = 1
			-- По умолчанию запрос НЕ выполняется при сохранении файла —
			-- выполнение по <CR> или <Leader>S. Меняется на 1, если удобнее "сохранил = выполнил".
			vim.g.db_ui_execute_on_save = 0
			-- Подключения хранятся в ~/.local/share/nvim/db_ui/connections.json
		end,
	},
}