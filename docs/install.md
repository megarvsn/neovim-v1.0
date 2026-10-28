# Установка и первый запуск

Обзор конфигурации и остальные разделы — в основном [README.md](../README.md).

**Оглавление:**

- [Установка на чистый Mac](#установка-на-чистый-mac)
- [Установка на Linux](#установка-на-linux)
- [Установка на Windows](#установка-на-windows) (WSL2 — рекомендуется; нативный — с ограничениями)
- [Первый запуск и проверка](#первый-запуск-и-проверка-любая-платформа)

## Установка на чистый Mac

Neovim 0.9.5+ минимум (актуальный конфиг рассчитан на 0.12+ — treesitter main-branch).

```bash
# 0. Компилятор (нужен для сборки tree-sitter грамматик)
xcode-select --install

# 1. Основное
brew install neovim node ripgrep tree-sitter-cli

# 2. MySQL-клиент (для vim-dadbod)
brew install mysql-client
#   затем в ~/.zshrc добавьте строку:
#   export PATH=/opt/homebrew/opt/mysql-client/bin:$PATH

# 3. sshfs (если проекты монтируются с сервера по SSH)
brew install --cask macfuse            # macFUSE — до sshfs!
brew install gromgit/fuse/sshfs-mac
#   после установки macFUSE: расширенные настройки системы → разрешить
#   системное расширение и перезагрузить Mac

# 4. Сам конфиг (вместо <ваш-репозиторий> — адрес вашего git/GitHub)
git clone <ваш-репозиторий> ~/.config/nv_html
ln -sfn ~/.config/nv_html ~/.config/nvim
nvim                                    # первый запуск доставит плагины и LSP сам
```

## Установка на Linux

Требования те же по смыслу: Neovim 0.12+, node.js (для npm-пак Mason: LSP-серверы),
ripgrep (поиск Telescope), tree-sitter-cli и компилятор C (сборка грамматик),
mysql-клиент, sshfs + fuse3.

Пакет `neovim` в репозиториях дистрибутивов обычно старее 0.11, поэтому Neovim
рекомендуется ставить из офиц. релизов (tarball или AppImage, без компиляции):

```bash
# Neovim 0.12+ из офиц. релиза (x86_64; для arm64 файл nvim-linux-arm64.tar.gz)
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim && sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim
```

Затем системные зависимости (в зависимости от дистрибутива):

```bash
# Ubuntu / Debian
sudo apt install git build-essential curl ripgrep fd-find nodejs npm sshfs fuse3 default-mysql-client
#   на Debian/Ubuntu бинарник называется fdfind — Telescope ищет 'fd':
sudo ln -sf $(which fdfind) /usr/local/bin/fd
npm install -g tree-sitter-cli

# Fedora
sudo dnf install git gcc make curl ripgrep fd-find nodejs npm sshfs fuse3 mysql
npm install -g tree-sitter-cli

# Arch
sudo pacman -S --needed git base-devel ripgrep fd nodejs npm sshfs fuse3 mariadb-clients
npm install -g tree-sitter-cli
```

Настройка самой конфигурации после системных пакетов (одинакова для всех платформ):

```bash
git clone <ваш-репозиторий> ~/.config/nv_html
ln -sfn ~/.config/nv_html ~/.config/nvim
nvim
```

Для доступа к БД MySQL по SSH-туннелю `default-mysql-client` / `mysql` должны
находиться в PATH (в стандартных путях дистрибутивов — уже находятся).

## Установка на Windows

Есть два пути: WSL (рекомендуется — конфигурация рассчитана на Linux-среду) и
нативный запуск без WSL (с существенными ограничениями).

### Вариант 1: WSL2 (рекомендуется)

```powershell
# PowerShell с правами администратора: поставить WSL2 + Ubuntu
wsl --install
# перезагрузка, затем войти в Ubuntu
```

Внутри WSL установка полностью совпадает с Linux — следуйте разделу
«Установка на Linux» (команды Ubuntu/Debian) выше. Конфиг кладётся в
`~/.config/nv_html` с симлинком `~/.config/nvim` — то же самое.

Рекомендуемый терминал — [Windows Terminal](https://aka.ms/terminal) (цвета
kanagawa корректны; установите шрифт с иконками Nerd Font, иначе значки
neo-tree/lualine будут пустыми квадратами).

**Особенности и ограничения WSL:**

- Проекты держите в файловой системе WSL (`~/Projects`), а не в `/mnt/c/...`:
  доступ Windows↔WSL через `/mnt` на порядок медленнее — поиск Telescope и
  обход дерева при открытии проекта заметно тормозят.
- Системный буфер обмена Windows: Neovim в WSL не видит его сам. Нужен
  [win32yank.exe](https://github.com/equalsraf/win32yank/releases) в PATH внутри
  WSL (Neovim находит его автоматически). Простой путь, если на Windows уже стоит
  Neovim: `ln -s "/mnt/c/Program Files/Neovim/bin/win32yank.exe" ~/.local/bin/win32yank.exe`.
  Без него копипаст живёт только внутри WSL.
- sshfs внутри WSL — полноценный Linux-вариант: `:SshfsMount` работает. Если
  монтирование падает с «only root can use --mount option», разрешите
  монтирование пользователям: в `/etc/fuse.conf` раскомментируйте
  `user_allow_other`.
- Проводник видит файлы WSL по пути `\\wsl$\Ubuntu\home\<user>\...`.

### Вариант 2: без WSL (нативный Windows)

Конфигурация запустится, но часть возможностей рассчитана на POSIX-среду.

```powershell
# системные инструменты
winget install Neovim.Neovim Git.Git BurntSushi.ripgrep.MSVC OpenJS.NodeJS.LTS sharkdp.fd

# tree-sitter-cli и серверы Mason идут через npm
npm install -g tree-sitter-cli

# mysql-клиент для dadbod: установите MySQL Community (клиент) и добавьте
# папку bin в PATH, либо используйте WSL для работы с БД

# компилятор C для сборки tree-sitter грамматик
winget install Microsoft.VisualStudio.2022.BuildTools
#   в установщике выберите workload "Desktop development with C++"

# сам конфиг: на Windows Neovim читает его из %LOCALAPPDATA%\nvim
git clone <ваш-репозиторий> $env:LOCALAPPDATA\nv_html
New-Item -ItemType SymbolicLink -Path $env:LOCALAPPDATA\nvim -Target $env:LOCALAPPDATA\nv_html
```

Символьные ссылки в Windows требуют режима разработчика
(Settings → Privacy & Security → For developers → Developer Mode) или прав
администратора. Без них можно создать Junction (специальных прав не требует):

```powershell
New-Item -ItemType Junction -Path $env:LOCALAPPDATA\nvim -Target $env:LOCALAPPDATA\nv_html
```

**Ограничения нативного Windows (главное):**

- **sshfs-способ работать не будет**: `lua/core/sshfs.lua` вызывает `sshfs`
  и монтирует в `~/Projects` — это Linux/macOS-стиль. SSHFS-Win (WinFsp)
  существует, но модуль под него не адаптирован, и `:SshfsMount`/`:SshfsList`
  в нативном Windows не рассчитаны на работу. Проекты с сервера — через WSL
  (Вариант 1) или через «Способ 2»: git + локальный web-стек ([docs/sshfs.md](sshfs.md)).
- Работает в нативном: тема, Telescope (ripgrep/fd), LSP/мason, treesitter
  (с Build Tools), автопары, буфер обмена Windows «из коробки», git
  (fugitive/gitsigns), toggleterm.
- Пути в конфиге вида `~/.local/share/nvim/...` Neovim на Windows корректно
  транслирует в `%LOCALAPPDATA%` — править не нужно.

## Первый запуск и проверка (любая платформа)

> На Windows запускайте внутри WSL: в нативном режиме первый запуск пройдёт,
> но sshfs-модуль и часть POSIX-пути рассчитаны на Linux/macOS (ограничения см. выше).

1. `nvim` — при первом запуске lazy.nvim скопирован сам, затем автоматически
   `Lazy sync` (все плагины), mason поставит LSP-серверы (нужен node),
   treesitter соберёт грамматики (нужен tree-sitter-cli и компилятор).
   На медленной сети подождите окончание всех загрузок внизу окна.
2. Проверки:
   - `:checkhealth` — общая диагностика (ищите строки ERROR/WARN)
   - `:Mason` — все LSP-серверы установлены (html, cssls, ts_ls, intelephense, sqlls, emmet_ls, lua_ls)
   - `:LspInfo` — в открытом html/php-файле виден работающий сервер
   - `:InspectTree` — в html-файле открывается дерево разбора (значит грамматики есть)
3. Настройте свои проекты в `lua/core/sshfs.lua` (таблица `projects`),
   подключение к БД — после `:SshTunnel 3306` в DBUI ([database.md](database.md)).
4. Версии плагинов закреплены в `lazy-lock.json` — обновление: `:Lazy update`,
   откат к проверенной точке: `:Lazy restore`.