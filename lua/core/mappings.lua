-- ЯДРО КОНФИГУРАЦИИ (не плагин): все глобальные горячие клавиши
-- Механизм маппингов: :help mapping или https://neovim.io/doc/user/map.html
-- Leader (глобальная клавиша-модификатор)
vim.g.mapleader = ' '

-- Вставка / выход
vim.keymap.set('i', 'jj', '<ESC>', { desc = 'Выйти в обычный режим' })

-- Базовые удобства
vim.keymap.set('n', '<Esc>', ':noh<CR><Esc>', { desc = 'Снять подсветку поиска' })
vim.keymap.set('n', 'Y', 'y$', { desc = 'Копировать до конца строки' })

-- --- Файлы -------------------------------------------------------------
vim.keymap.set('n', '<leader>e', ':Neotree left toggle reveal<CR>', { desc = 'Дерево файлов' })
vim.keymap.set('n', '<leader>w', ':w<CR>', { desc = 'Сохранить файл' })
-- Открыть текущий файл в браузере (вёрстка; php-окружение не подгрузится)
vim.keymap.set('n', '<leader>o', function()
	local f = vim.fn.expand('%')
	if f == '' then
		vim.notify('Файл не открыт — нечего смотреть в браузере', vim.log.levels.WARN)
		return
	end
	local opener = vim.fn.has('mac') == 1 and 'open' or 'xdg-open'
	vim.cmd('silent! !' .. opener .. ' "' .. f .. '"')
	vim.notify('Открыт в браузере: ' .. f, vim.log.levels.INFO)
end, { desc = 'Открыть файл в браузере' })

-- --- Поиск (<leader>f) -------------------------------------------------
vim.keymap.set('n', '<leader>ff', ':Telescope find_files<CR>', { desc = 'Файл по имени' })
vim.keymap.set('n', '<leader>fw', ':Telescope live_grep<CR>', { desc = 'Текст по проекту' })
vim.keymap.set('n', '<leader>fr', ':Telescope resume<CR>', { desc = 'Вернуть последний результат поиска' })
vim.keymap.set('n', '<leader>fb', ':Telescope buffers<CR>', { desc = 'Открытые буферы' })
-- ]q / [q — следующий / предыдущий результат quickfix (<leader>fw, Trouble)
vim.keymap.set('n', ']q', ':cnext<CR>', { desc = 'Следующий результат поиска/ошибки' })
vim.keymap.set('n', '[q', ':cprev<CR>', { desc = 'Предыдущий результат поиска/ошибки' })
vim.keymap.set('n', '<leader>fh', ':Telescope help_tags<CR>', { desc = 'Документация Neovim' })
vim.keymap.set('n', '<leader>fo', ':Telescope oldfiles<CR>', { desc = 'Недавние файлы' })
vim.keymap.set('n', '<leader>fu', ':Telescope undo<CR>', { desc = 'История правок файла (undo)' })
-- ]d / [d — прыжки по ошибкам LSP/линтера (диагностике)
vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ count = 1, float = true }) end,
	{ desc = 'Следующая ошибка' })
vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = -1, float = true }) end,
	{ desc = 'Предыдущая ошибка' })
-- <leader>f/ — нечёткий поиск по текущему файлу
vim.keymap.set('n', '<leader>f/', function()
	require('telescope.builtin').current_buffer_fuzzy_find({
		previewer = false, layout_config = { width = 0.6, height = 0.4 }
	})
end, { desc = 'Поиск в текущем файле' })

-- --- Git (<leader>g) ---------------------------------------------------
vim.keymap.set('n', '<leader>gs', ':Git<CR>', { desc = 'Статус/стейджинг' })
vim.keymap.set('n', '<leader>gc', ':Git commit<CR>', { desc = 'Коммит' })
vim.keymap.set('n', '<leader>gp', ':Git push<CR>', { desc = 'Отправить (push)' })
vim.keymap.set('n', '<leader>gP', ':Git pull<CR>', { desc = 'Получить (pull)' })
vim.keymap.set('n', '<leader>gb', ':Git blame<CR>', { desc = 'Кто менял строки (blame)' })
vim.keymap.set('n', '<leader>gl', ':Flog<CR>', { desc = 'История коммитов (граф)' })

-- --- Стиль по html-классу (функция в lua/core/cssjump.lua) --------------
vim.keymap.set('n', '<leader>lC', function() require('core.cssjump').jump() end,
	{ desc = 'Определение класса/ID в стилях' })

-- --- База данных (<leader>d) -------------------------------------------
vim.keymap.set('n', '<leader>db', ':DBUI<CR>', { desc = 'Обзор базы (DBUI)' })

-- --- Окна и вкладки ------------------------------------------------------
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>', { desc = 'Окно вверх' })
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>', { desc = 'Окно вниз' })
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>', { desc = 'Окно влево' })
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>', { desc = 'Окно вправо' })
-- Alt+h/j/k/l — размер окна (шире/уже/выше/ниже)
vim.keymap.set('n', '<A-h>', ':vertical resize +2<CR>', { desc = 'Окно шире' })
vim.keymap.set('n', '<A-l>', ':vertical resize -2<CR>', { desc = 'Окно уже' })
vim.keymap.set('n', '<A-j>', ':resize -2<CR>', { desc = 'Окно ниже' })
vim.keymap.set('n', '<A-k>', ':resize +2<CR>', { desc = 'Окно выше' })
vim.keymap.set('n', '|', ':vsplit<CR>', { desc = 'Вертикальный сплит' })
vim.keymap.set('n', '\\', ':split<CR>', { desc = 'Горизонтальный сплит' })

-- Вкладки
vim.keymap.set('n', '<Tab>', ':BufferLineCycleNext<CR>', { desc = 'Следующая вкладка' })
vim.keymap.set('n', '<s-Tab>', ':BufferLineCyclePrev<CR>', { desc = 'Предыдущая вкладка' })
vim.keymap.set('n', '<Leader>x', ':BufferLinePickClose<CR>', { desc = 'Выбрать вкладку на закрытие' })
vim.keymap.set('n', '<c-x>', ':BufferLineCloseOthers<CR>', { desc = 'Закрыть все вкладки кроме текущей' })
vim.keymap.set('n', '<leader>bd', ':bdelete<CR>', { desc = 'Закрыть текущий буфер (вкладку)' })

-- --- Тумблеры интерфейса (<leader>u) -------------------------------------
vim.keymap.set('n', '<leader>ud', function()
	if vim.diagnostic.is_enabled() then
		vim.diagnostic.enable(false)
		vim.notify('Диагностика скрыта', vim.log.levels.INFO)
	else
		vim.diagnostic.enable(true)
		vim.notify('Диагностика показана', vim.log.levels.INFO)
	end
end, { desc = 'Показать/скрыть ошибки LSP' })

vim.keymap.set('n', '<leader>uw', function()
	vim.opt.wrap = not vim.opt.wrap:get()
	vim.notify('Перенос строк: ' .. (vim.opt.wrap:get() and 'вкл' or 'выкл'), vim.log.levels.INFO)
end, { desc = 'Перенос длинных строк вкл/выкл' })

vim.keymap.set('n', '<leader>uF', function()
	vim.g.disable_autoformat = not vim.g.disable_autoformat
	vim.notify('Формат при сохранении: ' .. (vim.g.disable_autoformat and 'ВЫКЛ' or 'вкл'), vim.log.levels.INFO)
end, { desc = 'Формат при сохранении вкл/выкл' })

vim.keymap.set('n', '<leader>us', function()
	local on = not vim.opt.spell:get()
	vim.opt.spell = on
	vim.opt.spelllang = 'ru,en'
	vim.notify('Проверка орфографии (ru,en): ' .. (on and 'вкл' or 'выкл'), vim.log.levels.INFO)
end, { desc = 'Орфография вкл/выкл (ru,en)' })

-- Панели (Trouble): см. lua/plugins/trouble.lua — <leader>qq/qQ/qf/qL/cs/cl
-- LSP-клавиши: см. lua/plugins/lsp.lua — <leader>lr/la/lf/ls, gd, K, gi
-- Терминал: <C-\>  (см. lua/plugins/toggleterm.lua)