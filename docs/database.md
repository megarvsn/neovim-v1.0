# Доступ к базе данных сервера (MySQL)

Обзор конфигурации и остальные разделы — в основном [README.md](../README.md).

Инструменты: [vim-dadbod](https://github.com/tpope/vim-dadbod) — выполнение SQL
из буфера Neovim, [vim-dadbod-ui](https://github.com/kristijanhusak/vim-dadbod-ui) —
обзорщик базы с деревом таблиц. Подключение — через SSH-туннель (`:SshTunnel`,
настройка туннеля в `lua/core/sshfs.lua`).

Шпаргалка клавиш БД — в [keymap.md «База данных»](keymap.md#7-база-данных),
полный список `:команд` — в [commands.md](commands.md).

## Порядок работы

1. `:SshTunnel 3306` — открывает туннель localhost:3306 → бд сервера.
2. `<leader>db` (или `:DBUI`) — открывает обзорщик базы:
   - Add connection → `mysql://логин:пароль@127.0.0.1:3306/имя_базы`
   - В дереве: таблицы → `<CR>` — показать содержимое, `S` — схема.
3. В SQL-файлах: запрос под курсором или в визуальном режиме — `<CR>` (или `<Leader>S`),
   выполняется через туннель. История запросов сохраняется.

Требования: `brew install mysql-client` (клиент `mysql` должен быть в PATH;
строка `export PATH=/opt/homebrew/opt/mysql-client/bin:$PATH` в `~/.zshrc`).