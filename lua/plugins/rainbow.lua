return {
	{
		"hiphish/rainbow-delimiters.nvim",
		-- Радужная раскраска вложенных пар: открывающий и закрывающий
		-- тег одного элемента — одного цвета, уровни вложенности — разных.
		-- Дефолты (query `rainbow-delimiters` для html) уже покрывают теги.
		event = { "BufReadPost", "BufNewFile" },
	},
}