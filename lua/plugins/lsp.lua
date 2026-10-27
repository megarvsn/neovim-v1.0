return {
	{
		"neovim/nvim-lspconfig",
		config = function()
			-- 0. Capabilities от nvim-cmp (автодополнение из LSP)
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Общая настройка для всех серверов (Neovim 0.11+)
			vim.lsp.config("*", { capabilities = capabilities })

			-- 1. lua_ls: знает про глобальный объект 'vim' (для правки конфигов Neovim)
			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})

			-- 2. Включаем серверы под стек:
			--    html (html), css/scss (cssls), js/ts (ts_ls), php/Битрикс (intelephense),
			--    sql (sqlls), emmet (emmet_ls)
			vim.lsp.enable({ "lua_ls", "html", "cssls", "ts_ls", "intelephense", "sqlls", "emmet_ls" })

			-- 3. Красивые иконки в колонке слева
			local signs = { Error = "❌", Warn = "⚠️", Hint = "💡", Info = "ℹ️" }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			end

			-- 4. НАСТРОЙКА ОТОБРАЖЕНИЯ ОШИБОК В КОНЦЕ СТРОКИ
			vim.diagnostic.config({
				virtual_text = {
					spacing = 4,
					prefix = "■",
					severity_sort = true,
				},
				undercurl = true,
				update_in_insert = false,
				float = { border = "rounded" },
			})

			-- Показ полного текста ошибки при задержке курсора на строке
			vim.api.nvim_create_autocmd("CursorHold", {
				group = vim.api.nvim_create_augroup("UserDiagnosticsFloat", {}),
				callback = function()
					vim.diagnostic.open_float(nil, { focusable = false, border = "rounded" })
				end,
			})

			-- 5. Настройка горячих клавиш при подключении к LSP
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

					vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = ev.buf, desc = "К определению" })
					vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = ev.buf, desc = "Документация" })
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = ev.buf, desc = "К реализации" })
					-- <C-k> занят навигацией по окнам в core/mappings.lua,
					-- поэтому signature help висит на <leader>ls
					vim.keymap.set("n", "<Leader>D", vim.lsp.buf.type_definition, { buffer = ev.buf, desc = "К определению типа" })
					vim.keymap.set("n", "<Leader>lr", vim.lsp.buf.rename, { buffer = ev.buf, desc = "Переименовать символ" })
					vim.keymap.set({ "n", "v" }, "<Leader>la", vim.lsp.buf.code_action, { buffer = ev.buf, desc = "Быстрые действия" })
					vim.keymap.set("n", "<Leader>lf", function()
						vim.lsp.buf.format({ async = true })
					end, { buffer = ev.buf, desc = "Форматировать (LSP)" })
					vim.keymap.set("n", "<Leader>ls", vim.lsp.buf.signature_help, { buffer = ev.buf, desc = "Аргументы функции" })
				end,
			})

			-- ИСПРАВЛЕНИЕ ПРОЗРАЧНОСТИ И НАСТРОЙКА ОКНА HOVER (Shift-K)
			-- Принудительно отключаем прозрачность для всех новых окон LSP
			local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
			function vim.lsp.util.open_floating_preview(contents, syntax, opts)
				opts = opts or {}
				opts.border = opts.border or "rounded" -- Скругленная рамка
				local bufnr, winnr = orig_util_open_floating_preview(contents, syntax, opts)
				-- Отключаем прозрачность окна (0 — полностью непрозрачное окно)
				vim.wo[winnr].winblend = 0
				return bufnr, winnr
			end
			-- Цвета рамок берутся из темы (kanagawa)
		end,
	},
}