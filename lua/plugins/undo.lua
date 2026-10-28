-- ПЛАГИН: telescope-undo.nvim (https://github.com/debugloop/telescope-undo.nvim)
-- Локальная система контроля версий: persistent undo с поиском по истории и
-- откатом отдельных изменений (<leader>fu).
return {
	{
		"debugloop/telescope-undo.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		lazy = true,
		keys = {
			{
				"<leader>fu",
				function()
					require("telescope").extensions.undo.undo()
				end,
				desc = "История правок (локальные версии)",
			},
		},
	},
}