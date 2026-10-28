-- ЯДРО КОНФИГУРАЦИИ (не плагин): базовые настройки Neovim
-- Опции и их документация: :help options или https://neovim.io/doc/user/options.html
-- Номера строк
vim.wo.number = true
vim.wo.relativenumber = true

-- Мышь
vim.opt.mouse = "a"
vim.opt.mousefocus = true

-- Буфер обмена
vim.opt.clipboard = "unnamedplus"

-- Отступы
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

-- Прочее
-- Авто-перезагрузка файла при изменении извне (git pull, другой редактор)
vim.opt.autoread = true
-- Плавный скролл на Ctrl+d/Ctrl+u
vim.opt.smoothscroll = true

-- Сворачивание блоков по дереву Treesitter (za — свернуть/развернуть блок;
-- zR/zM — развернуть/свернуть всё). Без парсера работает как обычный vim.
-- Сворачивать вручную: по умолчанию всё раскрыто (foldlevelstart = 99).
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
vim.opt.scrolloff = 8
vim.opt.wrap = false
vim.opt.termguicolors = true
-- Подсветка строки с курсором (визуальная опора при чтении строк кода)
vim.opt.cursorline = true

-- Локальная история версий: persistent undo (переживает закрытие Neovim и перезагрузку)
local undodir = vim.fn.stdpath('data') .. '/undo'
pcall(vim.fn.mkdir, undodir, 'p')
vim.opt.undofile = true
vim.opt.undodir = undodir

-- Поведение автодополнения (nvim-cmp) и отзывчивость LSP
vim.opt.completeopt = 'menu,menuone,noselect'
vim.opt.updatetime = 250

-- Символы-заполнители (fillchars)
vim.opt.fillchars = {
	vert = "│",
	fold = "⠀",
	eob = " ", -- без «~» в пустой области после конца буфера
	-- diff = "⣿", -- варианты: ⣿ ░ ─ ╱
	msgsep = "‾",
	foldopen = "▾",
	foldsep = "│",
	foldclose = "▸",
}
