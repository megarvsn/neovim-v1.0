-- ПЛАГИН: nvim-lint (https://github.com/mfussenegger/nvim-lint)
-- Линтеры после сохранения (eslint для js/ts); результаты — в диагностику.
return {
	{
		"mfussenegger/nvim-lint",
		config = function()
			require("lint").linters_by_ft = {
				typescript = { "eslint" },
				typescriptreact = { "eslint" },
				javascript = { "eslint" },
				javascriptreact = { "eslint" },
			}
			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
	},
}
