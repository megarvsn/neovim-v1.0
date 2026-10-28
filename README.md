# NeoVim IDE для веб-разработки (HTML/SCSS/JS + 1С-Битрикс + MySQL)

Конфигурация построена как IDE для фронтенда (html, scss, javascript, svg) и бэкенда на
1С-Битрикс с MySQL. Проекты с сервера монтируются по sshfs в `~/Projects/<имя>` — Neovim
работает с ними как с обычными папками: при первом открытии файлы скачиваются с сервера
автоматически (это делает sshfs), при сохранении — отправляются на сервер сразу.
Для работы с базой данных сервера используется vim-dadbod через SSH-туннель.

Словарь читается по порядку: сначала обзор и архитектура (здесь), затем детали по темам
(каталог `docs/`), практические уроки — в каталоге `tutorial/`.

## Документация (каталог `docs/`)

| Файл | Содержание |
|---|---|
| [docs/install.md](docs/install.md) | Установка на чистый Mac и Linux, первый запуск и проверки |
| [docs/sshfs.md](docs/sshfs.md) | Проекты с сервера: sshfs-монтаж, `.ignore`, Способ 2 (git + локальный стек) |
| [docs/database.md](docs/database.md) | MySQL через SSH-туннель: dadbod, обзорщик DBUI, запросы из буфера |
| [docs/plugins.md](docs/plugins.md) | Все плагины: что делает, как пользоваться (с оглавлением) |
| [docs/keymap.md](docs/keymap.md) | Полный справочник горячих клавиш (11 разделов) |
| [docs/commands.md](docs/commands.md) | Реестр `:команд` (файлы, плагины, LSP, git, БД, sshfs, undo, терминал) |

## Туториал (каталог `tutorial/`)

Практические уроки с реальными примерами; проходить по порядку.

| Глава | Содержание |
|---|---|
| [tutorial/01-first-steps.md](tutorial/01-first-steps.md) | Первые шаги: открытие файла, перемещение, правки, сохранение, выход |
| [tutorial/02-navigation.md](tutorial/02-navigation.md) | Навигация по проекту: Telescope, neo-tree, окна/вкладки, leap |
| [tutorial/03-editing.md](tutorial/03-editing.md) | Редактирование: операторы, текстовые объекты, поиск/замена, визуальный режим |
| [tutorial/04-html-scss.md](tutorial/04-html-scss.md) | Ежедневный фронтенд: авто-теги, переход к стилям, форматирование |
| [tutorial/05-lsp.md](tutorial/05-lsp.md) | Работа с кодом: автодополнение, ошибки, переименование, документация |
| [tutorial/06-git.md](tutorial/06-git.md) | Git-цикл: знаки правок → стейдж → коммит → push |
| [tutorial/07-server.md](tutorial/07-server.md) | Работа с Bitrix-проектом на сервере (sshfs) |
| [tutorial/08-database.md](tutorial/08-database.md) | База данных: туннель, обзорщик, запросы |
| [tutorial/09-undo-history.md](tutorial/09-undo-history.md) | Локальная история версий и восстановление файла |
| [tutorial/10-help-tuning.md](tutorial/10-help-tuning.md) | Справка, темы, тумблеры, терминал, добавление проекта/плагина |

## Архитектура конфигурации

```
init.lua                  — точка входа
lua/
├── core/
│   ├── configs.lua       — базовые настройки Neovim (номера строк, клавиатура, undo)
│   ├── mappings.lua      — глобальные горячие клавиши
│   ├── cssjump.lua       — переход от html-класса/ID к его определению в стилях
│   ├── lazy.lua          — bootstrap и настройки менеджера плагинов lazy.nvim
│   └── sshfs.lua         — команды :SshfsMount/:SshfsUnmount/:SshfsList/:SshTunnel
└── plugins/              — по файлу на плагин (auto-импортируются lazy.nvim)
    ├── lsp.lua           — LSP-серверы и их настройки
    ├── mason.lua         — установка LSP-серверов и инструментов
    ├── treesitter.lua    — парсеры и подсветка
    ├── cmp.lua           — автодополнение
    ├── autotag.lua       — авто-пары html-тегов (закрытие и переименование пары)
    ├── conform.lua       — форматирование при сохранении
    ├── nvim-lint.lua     — линтеры (eslint для js/ts)
    ├── autopairs.lua     — авто-закрытие скобок и кавычек
    ├── indent.lua        — линии отступов (вложенность блоков)
    ├── dadbod.lua        — доступ к MySQL
    ├── matchup.lua       — подсветка парного тега/скобки и прыжок по %
    ├── rainbow.lua       — радужные цвета вложенных тегов/скобок
    ├── undo.lua          — локальная история версий (persistent undo)
    ├── fugitive.lua      — git для своих серверов и GitHub
    ├── gitsigns.lua      — git-знаки в строках
    ├── telescope.lua     — поиск/навигация
    ├── neo-tree.lua      — дерево файлов
    ├── bufferline.lua    — вкладки-буферы
    ├── lualine.lua       — статусная строка
    ├── dashboard.lua     — стартовый экран
    ├── kanagawa.lua      — цветовая тема (тёплая, wave)
    ├── which-key.lua     — справочник горячих клавиш по <leader> (на русском)
    ├── trouble.lua       — панель ошибок/символов
    ├── leap.lua          — быстрый переход к месту на экране (motion)
    └── toggleterm.lua    — терминал внутри Neovim
docs/                     — справка по темам (см. оглавление выше)
tutorial/                 — пошаговый туториал (см. оглавление выше)
lazy-lock.json            — зафиксированные версии плагинов
```

Подключение каталогов: главный каталог — `~/.config/nv_html`; каталог `~/.config/nvim`
— симлинк на него, поэтому обычный запуск `nvim` использует именно эту конфигурацию.

## Быстрые начала сразу после установки

- открыть проект/файл: `<leader>ff` (поиск по имени), `<leader>e` (дерево слева)
- найти текст по всему проекту: `<leader>fw`
- сохранить: `<leader>w`; найти любую клавишу: `<leader>?`
- полный туториал — [tutorial/01-first-steps.md](tutorial/01-first-steps.md)