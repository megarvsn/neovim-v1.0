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
