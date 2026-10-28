-- ПЛАГИН: lazy.nvim (https://github.com/folke/lazy.nvim)
-- Менеджер плагинов: установка/обновление, ленивая загрузка, lockfile.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- mapleader/maplocalleader нужно задать ДО загрузки lazy.nvim, чтобы
-- маппинги применились верно; здесь же обычно задают другие настройки (vim.opt)
-- vim.g.mapleader = " "
-- vim.g.maplocalleader = "\\"

-- Настройка lazy.nvim
require("lazy").setup({
  spec = {
    -- импорт ваших плагинов
    { import = "plugins" },
  },
  -- Здесь же можно задать любые другие настройки (подробности в документации)
  -- цветовая схема, используемая на время установки плагинов.
  -- install = { colorscheme = { "habamax" } },
  -- автоматическая проверка обновлений плагинов
  checker = { enabled = true },
})
