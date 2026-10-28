-- ПЛАГИНЫ: leap.nvim (https://codeberg.org/andyg/leap.nvim)
--          vim-repeat (https://github.com/tpope/vim-repeat)
-- Быстрый motion: прыжок к видимому тексту по 1–2 буквам (s/S/gs).
-- Репозиторий перенесён автором с GitHub на Codeberg (GitHub-зеркало очищено,
-- исходников в нём нет) — поэтому указываем url напрямую.
return {
	"andyg/leap.nvim",
	url = "https://codeberg.org/andyg/leap.nvim",
	dependencies = { "tpope/vim-repeat" },
	config = function()
		vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap)")
		vim.keymap.set("n", "S", "<Plug>(leap-from-window)")
		vim.keymap.set({ "n", "x", "o" }, "gs", "<Plug>(leap-visit)")
	end,
}