return {
	{
		'nvim-treesitter/nvim-treesitter',
		config = function()
			require('nvim-treesitter.config').setup({
				ensure_installed = {
					"go",
					"lua",
					"typescript",
					"javascript",
					"markdown",
					"markdown_inline",
					"php",
					"html",
					"scss",
					"css",
					"json",
					"yaml",
					"xml",
					"sql",
					"zsh",
					"bash",
					"csv",
					"passwd",
					"pug",
					"query",
					"python",
					"regex",
					"robots_txt",
					"ssh_config",
					"http"
				},
				auto_install = true,
				highlight = {
					enable = true,
				}
			})
		end
	}
}

