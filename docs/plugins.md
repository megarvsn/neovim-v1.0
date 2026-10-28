# Плагины: что стоит и как пользоваться

Обзор конфигурации и остальные разделы — в основном [README.md](../README.md).
Каждый плагин соответствует одному файлу в `lua/plugins/` (см. «Архитектура» в README).

**Оглавление:**
- [Менеджер плагинов и стартовые экраны](#менеджер-плагинов-и-стартовые-экраны)
  - [lazy.nvim](#lazynvim--folkelazynvim-менеджер-плагинов)
  - [dashboard-nvim](#dashboard-nvim--nvimdevdashboard-nvim-стартовый-экран)
- [Навигация и поиск](#навигация-и-поиск)
  - [telescope.nvim](#telescopenvim--nvim-telescopetelescopenvim-нечёткий-поиск)
  - [telescope-undo.nvim](#telescope-undonvim--debuglooptelescope-undonvim-история-правок-файла)
  - [leap.nvim](#leapnvim--andygleapnvim-motion--быстрые-прыжки)
  - [nvim-spectre](#nvim-spectre--nvim-packnvim-spectre-массовая-замена-по-проекту)
  - [neo-tree.nvim](#neo-treenvim--nvim-neo-treeneo-treenvim-дерево-файлов)
  - [nvim-treesitter](#nvim-treesitter--nvim-treesitternvim-treesitter-подсветка-и-парсеры)
  - [vim-matchup](#vim-matchup--andymassvim-matchup-парные-теги-и-скобки)
  - [rainbow-delimiters.nvim](#rainbow-delimitersnvim--hiphishrainbow-delimitersnvim-радужные-вложенные-пары)
- [LSP и автодополнение](#lsp-и-автодополнение)
  - [mason.nvim](#masonnvim--mason-orgmasonnvim--mason-lspconfig-установка-lsp-серверов)
  - [LSP](#lsp--neovimnvim-lspconfig-в-буферах-с-кодом)
  - [nvim-cmp](#nvim-cmp--hrsh7thnvim-cmp-автодополнение)
  - [nvim-ts-autotag](#nvim-ts-autotag--windwpnvim-ts-autotag-авто-пары-html-тегов)
  - [conform.nvim](#conformnvim--stevearcconformnvim-форматирование-при-сохранении)
  - [nvim-lint](#nvim-lint--mfusseneggernvim-lint-линтеры)
- [Отображение](#отображение)
  - [bufferline.nvim](#bufferlinenvim--akinshobufferlinenvim-и-lualine--nvim-lualinelualinenvim-статусная-строка)
  - [which-key.nvim](#which-keynvim--folkewhich-keynvim-подсказки-команд-на-ходу)
  - [trouble.nvim](#troublenvim--folketroublenvim-панели-ошибки-символы)
  - [kanagawa](#kanagawa--rebelotkanagawanvim-цветовая-тема-вариант-wave)
  - [nvim-autopairs](#nvim-autopairs--windwpnvim-autopairs-авто-закрытие-скобок-и-кавычек)
  - [indent-blankline.nvim](#indent-blanklinenvim--lukas-reinekeindent-blanklinenvim-линии-отступов)
- [Git и база данных](#git-и-база-данных)
  - [vim-fugitive + vim-flog](#vim-fugitive--vim-flog--tpopevim-fugitive-rbongvim-flog)
  - [gitsigns.nvim](#gitsignsnvim--lewis6991gitsignsnvim)
  - [vim-dadbod + vim-dadbod-ui](#vim-dadbod--vim-dadbod-ui--tpopevim-dadbod-kristijanhusakvim-dadbod-ui)
- [Терминал](#терминал)
  - [toggleterm.nvim](#toggletermnvim--akinshotoggletermnvim)

## Менеджер плагинов и стартовые экраны

### lazy.nvim — [folke/lazy.nvim](https://github.com/folke/lazy.nvim) (менеджер плагинов)
Устанавливает/обновляет плагины, управляет ленивой загрузкой.
- `:Lazy` — панель управления: статус, обновление, очистка
- `:Lazy sync` — синхронизировать (установить недостающее/удалить лишнее)
- `:Lazy update` — обновить все плагины; `:Lazy restore` — откатить к версии из lockfile
- Версии плагинов зафиксированы в `lazy-lock.json` — конфигурация воспроизводима.

### dashboard-nvim — [nvimdev/dashboard-nvim](https://github.com/nvimdev/dashboard-nvim) (стартовый экран)
Показывается при запуске Neovim без аргументов.
- `u` — обновить плагины (`Lazy update`)
- `f` — открыть файл через Telescope
- `e` — открыть дерево файлов

## Навигация и поиск

### telescope.nvim — [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) (нечёткий поиск)
Главный инструмент навигации по проекту (в т.ч. по sshfs-монтированному):
- `<leader>ff` — найти файл по имени
- `<leader>fr` — вернуть последний список Telescope (закрыли случайно — не искать заново)
- `<leader>fo` — недавно открытые файлы
- `<leader>fw` — найти текст по всему проекту (live grep)
- `<leader>fb` — открытые буферы
- `<leader>fh` — поиск по документации (vim-справка)
- Примеры внутри Telescope: `Ctrl+j/k` — перемещение, `<CR>` — открыть, `Tab` — не закрывая список.

### telescope-undo.nvim — [debugloop/telescope-undo.nvim](https://github.com/debugloop/telescope-undo.nvim) (история правок файла)
- `<leader>fu` — открыть историю; поиск; `<CR>` — откат к состоянию; в превью видно дифф.

### leap.nvim — [andyg/leap.nvim](https://codeberg.org/andyg/leap.nvim) (motion — быстрые прыжки)
Быстрое перемещение по видимому тексту без колеса мыши:
- `s` — прыжок к любому слову/месту на экране: набираете `s`, затем 1–2 буквы начала цели
- `S` — то же в открытых окнах кроме текущего (сравнение двух файлов)
- `gs` — «бумеранг»: прыжок в точку любого окна с включением выделения —
  операция выполняется прямо там (`d`/`c`/`y`/вставка), `Esc` — курсор
  возвращается обратно; удобно копировать «оттуда сюда» без ухода с места

### nvim-spectre — [nvim-pack/nvim-spectre](https://github.com/nvim-pack/nvim-spectre) (массовая замена по проекту)
Замена текста во всех файлах проекта с превью каждой замены перед применением —
для классов/текстов, когда LSP-переименование не подходит (html-атрибуты,
css-классы, обычные строки):
- `<leader>fs` — открыть; ввести поиск → заменить; в панели каждая правка
  подсвечена, отдельные можно отменить (`<Tab>` — снять выбор)
- `<leader>fS` — то же, только в текущем файле
- в visual-режиме `<leader>fs` — заменить выделенный текст

### neo-tree.nvim — [nvim-neo-tree/neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) (дерево файлов)
- `<leader>e` — открыть/закрыть боковую панель с файлами
- В дереве: `<CR>` — открыть файл, `a` — создать (имя с `/` создаст папку), `d` — удалить,
  `r` — переименовать, `c`/`x`/`p` — копировать/вырезать/вставить, `.` — показать контекстное меню.
- В Битрикс-проектах скрывает `upload/` и кеш (`bitrix/cache` и т.п.); `.htaccess` и другие
  dot-файлы видны. Для Telescope — файл `.ignore` в корне проекта (см. [sshfs.md](sshfs.md)).

### nvim-treesitter — [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) (подсветка и парсеры)
Основа для дерева разбора HTML/PHP/CSS/JS/SQL: на нём работают подсветка синтаксиса,
vim-matchup, nvim-ts-autotag, сворачивание блоков (`za`) и отступы. Грамматики ставятся
автоматически при первом запуске (`:TSUpdate` при обновлении).

### vim-matchup — [andymass/vim-matchup](https://github.com/andymass/vim-matchup) (парные теги и скобки)
Подсветка и прыжки по парным элементам (Treesitter; html, php+html, xml и др.):
- стоит курсором на имени тега — парный тег (открывающий ↔ закрывающий) подсвечивается
- `%` — прыжок к парному тегу/скобке и обратно

### rainbow-delimiters.nvim — [hiphish/rainbow-delimiters.nvim](https://github.com/hiphish/rainbow-delimiters.nvim) (радужные вложенные пары)
Уровни вложенности раскрашиваются разными цветами: открывающий и закрывающий
тег одного элемента — одного цвета, их родителей — другого. Наглядно в сложной
верстке. Цвета нейтральные (отдельной интеграции с kanagawa у плагина нет).

## LSP и автодополнение

### mason.nvim — [mason-org/mason.nvim](https://github.com/mason-org/mason.nvim) + [mason-lspconfig](https://github.com/mason-org/mason-lspconfig.nvim) (установка LSP-серверов)
Установлен набор под ваш стек: `html`, `cssls` (css/scss), `ts_ls` (js/ts),
`intelephense` (PHP/Битрикс), `sqlls` (SQL), `emmet_ls` (HTML-эммет), `lua_ls` (конфиг самого nvim).
- `:Mason` — менеджер пакетов (поставить/обновить/удалить инструмент)
- `:LspInfo` — какой сервер работает в текущем буфере
- intelephense не индексирует мусор Битрикс-проекта (upload, кеш, бэкапы —
  список исключений в `lua/plugins/lsp.lua`)

### LSP — [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) (в буферах с кодом)
- `gd` — перейти к определению; `gi` — к реализации; `<Leader>D` — к типу
- в html-файлах `gd` работает иначе: открывает выбор определений класса/ID
  в файлах стилей (см. `lua/core/cssjump.lua` и таблицу клавиш в [keymap.md](keymap.md))
- `K` — документация под курсором (hover)
- `<Leader>lr` — переименовать символ (во всём проекте)
- `<Leader>la` — быстрые действия (код-акции)
- `<Leader>lf` — форматировать файл средствами LSP
- `<Leader>ls` — подсказка по сигнатуре функции при вводе аргументов
- Ошибки отображаются в тексте (`■`) и в колонке слева.

### nvim-cmp — [hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp) (автодополнение)
Источники: LSP, файлы на диске (path), содержимое открытых буферов, SQL-колонки (dadbod), сниппеты.
- `<C-Space>` — вызвать автодополнение вручную
- `<Tab>`/`<S-Tab>` — выбрать следующий/предыдущий вариант
- `<CR>` — принять предложение; `<C-e>` — закрыть меню
- В командной строке `:` и `/` тоже работает автодополнение.
- Сниппеты: `<Tab>` внутри сниппета — прыжок к следующему плейсхолдеру.

### nvim-ts-autotag — [windwp/nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag) (авто-пары html-тегов)
Управляет парой тегов по дереву Treesitter (html, xml, php+html и др.):
- при вводе `<div>` закрывающий `</div>` дописывается автоматически
- правка имени одного тега меняет и парный ему: `<div></div>` →
  `cwspan<Esc>` даёт `<span></span>` — работает на любом из двух тегов,
  в том числе внутри смешанного php+html
- если автозакрытие не нужно, его можно отключить в `lua/plugins/autotag.lua` (`enable_close = false`)

### conform.nvim — [stevearc/conform.nvim](https://github.com/stevearc/conform.nvim) (форматирование при сохранении)
На сохранении автоматически форматирует: prettier (html/css/scss/js/ts/json),
sql-formatter (SQL), stylua (lua).
- `:ConformInfo` — какие форматтеры активны в текущем файле
- Ручной запуск: `<Leader>lf` или через LSP-форматирование.
- `<Leader>uF` — тумблер авто-формата при сохранении (например, надолго выключить, правя чужой код).

### nvim-lint — [mfussenegger/nvim-lint](https://github.com/mfussenegger/nvim-lint) (линтеры)
Eslint проверяет js/ts после сохранения файла; найденные им проблемы видны в Trouble.

## Отображение

### bufferline.nvim — [akinsho/bufferline.nvim](https://github.com/akinsho/bufferline.nvim) и lualine — [nvim-lualine/lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) (статусная строка)
Вкладки вверху с иконками файлов и счётчиками ошибок; снизу — режим, git-ветка,
ошибки/предупреждения в статусной строке, кодировка. Цвета обеих — из темы kanagawa.
- `<Tab>` — следующая вкладка; `<S-Tab>` — предыдущая
- `<Leader>x` — выбрать вкладку на закрытие; `<C-x>` — закрыть все, кроме текущей

### which-key.nvim — [folke/which-key.nvim](https://github.com/folke/which-key.nvim) (подсказки команд на ходу)
Справочник горячих клавиш прямо в Neovim: нажали `<leader>` и держите — на экране все
доступные команды с описаниями (все подписи на русском, сгруппированы логически:
Поиск, Git, База данных, LSP, Панели, Вид интерфейса).
- `<leader>?` — все клавиши текущего буфера
- Подсказка появляется автоматически при начале комбинации и прерывается, если вы нажали уже известную клавишу.

### trouble.nvim — [folke/trouble.nvim](https://github.com/folke/trouble.nvim) (панели: ошибки, символы)
- `<leader>qq` — все ошибки/предупреждения по проекту
- `<leader>qQ` — ошибки текущего файла
- `<leader>qf` — список quickfix; `<leader>qL` — локальный список
- `<leader>cs` — символы файла (дерево функций/переменных)
- `<leader>cl` — ссылки/определения текущего символа

### kanagawa — [rebelot/kanagawa.nvim](https://github.com/rebelot/kanagawa.nvim) (цветовая тема, вариант wave)
Тёплая тёмная палитра: тёмно-бежевый фон, янтарные/оливковые/розовые акценты,
умеренный контраст (спокойная для глаз, без холодной синевы). Непрозрачный фон.
Вариант переключается в `lua/plugins/kanagawa.lua`:
- `wave` — основная тёплая тёмная
- `dragon` — темнее и спокойнее (минимум акцентов)
- `lotus` — светлая тёплая
- `:colorscheme kanagawa-dragon` / `:colorscheme kanagawa-lotus` — на лету

### nvim-autopairs — [windwp/nvim-autopairs](https://github.com/windwp/nvim-autopairs) (авто-закрытие скобок и кавычек)
При наборе `(` автоматически добавляется `)`; кавычки `'`/`"` тоже.
- Интегрировано с автодополнением: выбор функции из подсказок получает скобки автоматически (`sort` → `sort(`)

### indent-blankline.nvim — [lukas-reineke/indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) (линии отступов)
Тонкие вертикальные линии по уровням отступов — сразу видно вложенность блоков:
где начинается/заканчивается функция, блок if, разметка HTML.
Отключены для dashboard, neo-tree, терминала и Telescope.

## Git и база данных
Git-плагины описаны в туториале [06-git.md](../tutorial/06-git.md) (цикл работы),
команды — в [commands.md («Git»)](commands.md#git-fugitivefloggitsigns); БД —
в [database.md](database.md). Кратко:

### vim-fugitive + vim-flog — [tpope/vim-fugitive](https://github.com/tpope/vim-fugitive), [rbong/vim-flog](https://github.com/rbong/vim-flog)
- `<leader>gs` — git-статус по-всему проекту (в нём `-` — стейдж/анстейдж файла, `cc` — коммит)
- `<leader>gc` — коммит, `<leader>gp` — push, `<leader>gP` — pull, `<leader>gb` — blame
- `<leader>gl` — граф истории (flog); свои серверы и GitHub работают одинаково

### gitsigns.nvim — [lewis6991/gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
- Знаки у строк слева (изменено/добавлено/удалено), `[c`/`]c` — прыжки по правкам
- `<leader>hp` — превью правки, `<leader>hs` — стейдж, `<leader>hr` — откат

### vim-dadbod + vim-dadbod-ui — [tpope/vim-dadbod](https://github.com/tpope/vim-dadbod), [kristijanhusak/vim-dadbod-ui](https://github.com/kristijanhusak/vim-dadbod-ui)
- `<leader>db` — обзорщик базы; в SQL-файле `<CR>` — выполнить, `<Leader>S` — то же
- Подключение строго через SSH-туннель: подробности в [database.md](database.md)

## Терминал

### toggleterm.nvim — [akinsho/toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim)
- `<C-\>` — открыть/закрыть терминал (по умолчанию вертикально)
- `<esc>` или `jj` — выйти из режима ввода в терминале
- `<C-h/j/k/l>` — переключаться между окнами как обычно
- Используется и для `:SshTunnel` (SSH-сессия в плавающем окне).