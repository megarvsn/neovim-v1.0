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