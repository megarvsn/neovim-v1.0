-- ПЛАГИН: gitsigns.nvim (https://github.com/lewis6991/gitsigns.nvim)
-- Git-знаки в строках, прыжки по правкам ([c/],]c), превью/стейдж/откат.
return {
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(lhs, rhs, desc)
            vim.keymap.set("n", lhs, rhs, { buffer = bufnr, desc = desc })
          end

          -- Прыжки между блоками правок
          map("]c", function()
            if vim.wo.diff then vim.cmd.normal({ "]c", bang = true }) else gs.nav_hunk("next") end
          end, "Следующая правка в файле")
          map("[c", function()
            if vim.wo.diff then vim.cmd.normal({ "[c", bang = true }) else gs.nav_hunk("prev") end
          end, "Предыдущая правка в файле")
          -- Строки
          map("<leader>hp", gs.preview_hunk, "Превью правки строки")
          map("<leader>hs", gs.stage_hunk, "Стейдж правки")
          map("<leader>hr", gs.reset_hunk, "Откат правки")
        end,
      })
    end,
  },
}