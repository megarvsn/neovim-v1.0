-- ПЛАГИН: conform.nvim (https://github.com/stevearc/conform.nvim)
-- Форматирование при сохранении: prettier (веб-стек), sql-formatter (SQL), stylua (Lua).
return {
	{
		"stevearc/conform.nvim",
		opts = {},
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					javascript = { "prettier" },
					typescript = { "prettier" },
					javascriptreact = { "prettier" },
					typescriptreact = { "prettier" },
					html = { "prettier" },
					css = { "prettier" },
					scss = { "prettier" },
					json = { "prettier" },
					sql = { "sql_formatter" },
					mysql = { "sql_formatter" },
				},
			})
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*",
				callback = function(args)
					-- Тумблер <leader>uF: временно отключить авто-формат
					-- (правка чужого кода — без переформатирования всего файла)
					if vim.g.disable_autoformat then
						return
					end
					require("conform").format({ bufnr = args.buf })
				end,
			})
		end,
	},
}
