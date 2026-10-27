return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.INFO] = " ",
					[vim.diagnostic.severity.HINT] = " ",
				},
			},
		})
		require("neo-tree").setup({
			close_if_last_window = false,
			filesystem = {
				-- Битрикс-проекты: не показывать кеш/бэкапы/upload.
				-- Тот же список для Telescope (fd/rg) задаётся файлом .ignore
				-- в корне проекта — шаблон в README (раздел sshfs).
				filtered_items = {
					hide_dotfiles = false, -- .htaccess и .settings.php видны
					hide_gitignored = false,
					never_show = { "upload" },
					never_show_by_pattern = {
						"**/bitrix/cache",
						"**/bitrix/managed_cache",
						"**/bitrix/stack_cache",
						"**/bitrix/html_pages",
						"**/bitrix/backup",
						"**/bitrix/tmp",
					},
				},
			},
		})
	end,
}
