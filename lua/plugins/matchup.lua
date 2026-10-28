-- ПЛАГИН: vim-matchup (https://github.com/andymass/vim-matchup)
-- Подсветка парного тега/скобки под курсором и прыжок по % (Treesitter).
return {
	{
		"andymass/vim-matchup",
		-- Подсветка парного тега/скобки под курсором (как matchparen) и
		-- прыжок по % между открывающим и закрывающим тегом.
		-- Интеграция с Treesitter включается сама (query для html/php/xml
		-- в комплекте плагина). README: не ленить через event — плагин
		-- и так грузит только минимум на старте.
		init = function()
			-- Обновление подсветки с задержкой при быстром движении курсора
			vim.g.matchup_matchparen_deferred = 1
		end,
	},
}