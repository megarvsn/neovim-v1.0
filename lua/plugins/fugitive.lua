-- ПЛАГИНЫ: vim-fugitive (https://github.com/tpope/vim-fugitive)
--          vim-flog (https://github.com/rbong/vim-flog)
-- Git в Neovim (свои серверы и GitHub — одинаково, через remote), граф истории.
return {
	{ "tpope/vim-fugitive" },
	{
		"rbong/vim-flog",
		lazy = true,
		cmd = { "Flog", "Flogsplit", "Floggit" },
		dependencies = {
			"tpope/vim-fugitive",
		},
	},
}
