-- Line numbers
vim.wo.number = true
vim.wo.relativenumber = true

-- Mouse
vim.opt.mouse = "a"
vim.opt.mousefocus = true

-- Clipboard
vim.opt.clipboard = "unnamedplus"

-- Ident Settings
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

-- Other
vim.opt.scrolloff = 8
vim.opt.wrap = false
vim.opt.termguicolors = true

-- Локальная история версий: persistent undo (переживает закрытие Neovim и перезагрузку)
local undodir = vim.fn.stdpath('data') .. '/undo'
pcall(vim.fn.mkdir, undodir, 'p')
vim.opt.undofile = true
vim.opt.undodir = undodir

-- Поведение автодополнения (nvim-cmp) и отзывчивость LSP
vim.opt.completeopt = 'menu,menuone,noselect'
vim.opt.updatetime = 250

-- Fillchars
vim.opt.fillchars = {
	vert = "│",
	fold = "⠀",
	eob = " ", -- suppress ~ at EndOfBuffer
	-- diff = "⣿", -- alternatives = ⣿ ░ ─ ╱
	msgsep = "‾",
	foldopen = "▾",
	foldsep = "│",
	foldclose = "▸",
}
