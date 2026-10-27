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
			})

			-- 5. Настройка горячих клавиш при подключении к LSP
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

					local opts = { buffer = ev.buf }
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
					-- <C-k> занят навигацией по окнам в core/mappings.lua,
					-- поэтому signature help висит на <leader>ls
					vim.keymap.set("n", "<Leader>ls", vim.lsp.buf.signature_help, opts)
					vim.keymap.set("n", "<Leader>D", vim.lsp.buf.type_definition, opts)
					vim.keymap.set("n", "<Leader>lr", vim.lsp.buf.rename, { buffer = ev.buf, desc = "Rename Symbol" })
					vim.keymap.set({ "n", "v" }, "<Leader>la", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "<Leader>lf", function()
						vim.lsp.buf.format({ async = true })
					end, opts)
				end,
			})

			-- 6. ИСПРАВЛЕНИЕ ПРОЗРАЧНОСТИ И НАСТРОЙКА ОКНА HOVER (Shift-K)
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

			-- Переопределяем цвета, связывая их с базовым фоном редактора (Normal)
			-- Ссылка link = "Normal" берет фон вашей текущей темы, убирая прозрачность
			vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
			-- Делаем рамку контрастной (например, оранжевой/персиковой #fab387)
			vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#fab387", link = "Normal" })
		end,
	},
}