-- СОБСТВЕННАЯ ФУНКЦИЯ (без отдельного плагина)
-- Переход к определению CSS-класса или идентификатора, на котором стоит курсор.
-- Клавиши: gd в html/php, <leader>lC глобально; выбор — Telescope
-- (https://github.com/nvim-telescope/telescope.nvim) по файлам стилей проекта.
-- Работает в html/php+html: имя класса или id ищется в файлах стилей
-- проекта (.css/.scss/.sass/.less), результаты открываются в Telescope —
-- выбор строки <CR> ведёт в файл на нужную строку.
--
-- Ищутся и селектор класса («.имя»), и селектор идентификатора («#имя»)
-- одним запросом, поэтому не важно, что именно под курсором.
-- Ограничение: SCSS-вложения вида `.nav { &-item {} }` составное имя
-- «nav-item» в исходнике не содержит и этим поиском не находится.

local M = {}

-- Слово под курсором: <cword> обрывается на дефисе («btn-primary»),
-- поэтому имя достаём вручную — буквы, цифры, дефисы и подчёркивания.
local function word_under_cursor()
	local line = vim.api.nvim_get_current_line()
	local col = vim.api.nvim_win_get_cursor(0)[2] -- 0-based

	local left = line:sub(1, col):match("[A-Za-z_][%w%-_]*$") or ""
	local right = line:sub(col + 1):match("^[%w%-_]*") or ""
	return left .. right
end

function M.jump()
	local word = word_under_cursor()
	if word == "" then
		vim.notify("Курсор не на имени класса или идентификатора", vim.log.levels.WARN)
		return
	end

	require("telescope.builtin").grep_string({
		prompt_title = 'Определения: "' .. word .. '"',
		search = "[.#]" .. word,
		use_regex = true,
		-- Только файлы стилей — так в списке остаются определения,
		-- а не использования (querySelector и т.п.)
		additional_args = { "--glob", "*.{css,scss,sass,less}" },
	})
end

-- В html-файлах gd открывает выбор определений в стилях
-- (для php остаётся переход по PHP-коду через LSP, там — <leader>lC)
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("UserCssJump", {}),
	pattern = { "html" },
	callback = function(args)
		vim.keymap.set("n", "gd", M.jump, {
			buffer = args.buf,
			desc = "Определение класса/ID в стилях",
		})
	end,
})

return M