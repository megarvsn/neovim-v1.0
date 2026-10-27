return {
	{
		"nvim-treesitter/nvim-treesitter",
		-- На ветке main плагин не поддерживает lazy-загрузку (требование официального README)
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").setup({})

			-- Грамматики под стек: html/scss/css, js/ts, php (Битрикс), sql
			require("nvim-treesitter").install({
				"html",
				"css",
				"scss",
				"javascript",
				"typescript",
				"php",
				"sql",
				"json",
				"yaml",
				"xml",
				"bash",
				"markdown",
				"markdown_inline",
				"lua",
				"query",
				"regex",
				"csv",
			})

			-- Подсветка включается нативно через vim.treesitter.start() (Neovim 0.12)
			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"html", "css", "scss", "javascript", "typescript",
					"javascriptreact", "typescriptreact", "php", "sql",
					"json", "yaml", "xml", "bash", "markdown", "lua", "csv",
				},
				callback = function()
					pcall(vim.treesitter.start)
				end,
			})
		end,
	},
}