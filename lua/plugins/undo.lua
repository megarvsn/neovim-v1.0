-- Локальная система контроля версий: persistent undo + поиск по истории через telescope
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
				desc = "Undo history (локальная история версий)",
			},
		},
	},
}