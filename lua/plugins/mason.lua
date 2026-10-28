-- ПЛАГИНЫ: mason-org/mason.nvim (https://github.com/mason-org/mason.nvim)
--          mason-org/mason-lspconfig.nvim (https://github.com/mason-org/mason-lspconfig.nvim)
-- Установка LSP-серверов и инструментов (prettier, stylua, sql-formatter).
return {
	{
		"mason-org/mason.nvim",
		opts = {
			-- Не-LSP инструменты для conform.nvim
			ensure_installed = { "prettier", "stylua", "sql-formatter" },
		},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		opts = {
			-- Серверы под стек: html/scss/js/ts, php (intelephense), sql, emmet
			ensure_installed = { "lua_ls", "html", "cssls", "ts_ls", "intelephense", "sqlls", "emmet_ls" },
		},
	},
}