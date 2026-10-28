-- ПЛАГИН: nvim-ts-autotag (https://github.com/windwp/nvim-ts-autotag)
-- Авто-пары html-тегов по дереву Treesitter: дописывает закрывающий тег
-- и переименовывает пару при правке любого из тегов (html, php+html, xml).
return {
	{
		"windwp/nvim-ts-autotag",
		event = "InsertEnter",
		config = function()
			-- Авто-пары тегов по дереву Treesitter:
			-- переименование пары тегов + автодополнение закрывающего
			require("nvim-ts-autotag").setup({
				opts = {
					enable_close = true, -- при вводе <div> сразу дописать </div>
					enable_rename = true, -- правка одного тега тянет за собой парный
					enable_close_on_slash = false,
				},
			})
		end,
	},
}