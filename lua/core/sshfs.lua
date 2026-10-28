-- ЯДРО КОНФИГУРАЦИИ (не плагин): команды :SshfsMount/:SshfsUnmount/:SshfsList/:SshTunnel
-- Монтирование проектов с сервера и туннели к MySQL.
-- Используемые инструменты: sshfs (https://github.com/libfuse/sshfs),
-- macFUSE (https://osxfuse.github.io/), OpenSSH (https://www.openssh.com/)
-- Проект монтируется в ~/Projects/<имя>: открывается как обычная папка в Neovim.
-- Опишите ваши проекты в таблице projects ниже:
local projects = {
	-- пример (раскомментируйте и поправьте путь):
	-- ["baza23"] = "baza23.ru:/home/bitrix/www",
}

-- Хост по умолчанию для :SshTunnel (SSH-туннель к MySQL на сервере)
local tunnel_host = "baza23.ru"

local root = vim.fn.expand("~/Projects")

local function is_mounted(dest)
	local ok, mounts = pcall(vim.fn.system, "mount")
	if not ok then
		return false
	end
	return mounts:find(dest, 1, true) ~= nil
end

local function project_names()
	local names = {}
	for name in pairs(projects) do
		table.insert(names, name)
	end
	table.sort(names)
	return names
end

local function mount(name)
	local remote = projects[name]
	if not remote then
		vim.notify(
			"SshfsMount: нет проекта '" .. name .. "'. Заполните таблицу projects в lua/core/sshfs.lua (:SshfsList)",
			vim.log.levels.ERROR
		)
		return
	end
	local dest = root .. "/" .. name
	if is_mounted(dest) then
		vim.notify("SshfsMount: " .. dest .. " уже смонтирован", vim.log.levels.WARN)
		return
	end
	vim.fn.mkdir(dest, "p")
	vim.fn.jobstart({ "sshfs", remote, dest, "-o", "reconnect,ServerAliveInterval=15,ConnectTimeout=10" }, {
		on_exit = function(_, code)
			vim.schedule(function()
				if code == 0 and is_mounted(dest) then
					vim.notify("Смонтирован проект " .. name .. ": " .. dest, vim.log.levels.INFO)
				else
					vim.notify(
						"SshfsMount: не удалось смонтировать " .. remote
							.. " (код " .. code .. "). Проверьте доступ: ssh " .. tunnel_host,
						vim.log.levels.ERROR
					)
				end
			end)
		end,
	})
end

local function unmount(name)
	local dest = root .. "/" .. name
	if not is_mounted(dest) then
		vim.notify("SshfsUnmount: " .. dest .. " не смонтирован", vim.log.levels.WARN)
		return
	end
	vim.fn.jobstart({ "umount", dest }, {
		on_exit = function(_, code)
			vim.schedule(function()
				if code == 0 then
					vim.notify("Отмонтирован: " .. dest, vim.log.levels.INFO)
				else
					vim.notify(
						"SshfsUnmount: umount не сработал (код " .. code .. "). Файл в папке открыт?",
						vim.log.levels.ERROR
					)
				end
			end)
		end,
	})
end

local function list()
	local lines = { "sshfs-проекты:" }
	local names = project_names()
	if #names == 0 then
		table.insert(lines, "  (таблица projects в lua/core/sshfs.lua пуста)")
	end
	for _, name in ipairs(names) do
		local dest = root .. "/" .. name
		local status = is_mounted(dest) and "✓ смонтирован" or "✗ не смонтирован"
		table.insert(lines, string.format("  %-12s %-18s %s", name, status, projects[name]))
	end
	vim.notify(table.concat(lines, "\n"), vim.log.levels.INFO)
end

-- SSH-туннель к серверу: локальный порт пробрасывается на удалённый localhost.
-- Используется для MySQL: :SshTunnel 3306  ->  localhost:3306 доступен базе на сервере.
local function tunnel(port)
	vim.cmd("ToggleTerm direction=float cmd='ssh -L " .. port .. ":localhost:" .. port .. " " .. tunnel_host .. "'")
	vim.notify(
		"Туннель открыт: localhost:" .. port .. " -> " .. tunnel_host .. ":" .. port,
		vim.log.levels.INFO
	)
end

vim.api.nvim_create_user_command("SshfsMount", function(o)
	mount(o.args)
end, { nargs = 1, desc = "Смонтировать проект в ~/Projects/<имя>", complete = project_names })

vim.api.nvim_create_user_command("SshfsUnmount", function(o)
	unmount(o.args)
end, { nargs = 1, desc = "Отмонтировать проект", complete = project_names })

vim.api.nvim_create_user_command("SshfsList", list, { nargs = 0, desc = "Список sshfs-проектов" })

vim.api.nvim_create_user_command("SshTunnel", function(o)
	tunnel(o.args)
end, { nargs = 1, desc = "SSH-туннель localhost:<порт> -> " .. tunnel_host })