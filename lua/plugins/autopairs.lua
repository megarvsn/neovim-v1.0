-- ПЛАГИН: nvim-autopairs (https://github.com/windwp/nvim-autopairs)
-- Авто-закрытие скобок и кавычек; интеграция с nvim-cmp.
-- Авто-закрытие скобок и кавычек при наборе + интеграция с автодополнением
return {
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			local npairs = require("nvim-autopairs")
			npairs.setup({})

			-- После принятия варианта автодополнения функция автоматически
			-- получает скобки (например, выбор "print" -> "print(")
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local cmp = require("cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	},
}