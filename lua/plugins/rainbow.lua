-- ПЛАГИН: rainbow-delimiters.nvim (https://github.com/hiphish/rainbow-delimiters.nvim)
-- Радужная раскраска вложенных пар: открывающий/закрывающий тег одного
-- элемента — одного цвета.
return {
	{
		"hiphish/rainbow-delimiters.nvim",
		-- Радужная раскраска вложенных пар: открывающий и закрывающий
		-- тег одного элемента — одного цвета, уровни вложенности — разных.
		-- Дефолты (query `rainbow-delimiters` для html) уже покрывают теги.
		event = { "BufReadPost", "BufNewFile" },
	},
}