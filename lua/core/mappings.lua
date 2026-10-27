-- Leader
vim.g.mapleader = ' '

-- Insert
vim.keymap.set('i', 'jj', '<ESC>')

-- Neo-tree
vim.keymap.set('n', '<leader>e', ':Neotree left toggle reveal<CR>')

-- Buffers
vim.keymap.set('n', '<leader>w', ':w<CR>')

-- Navigation
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')

-- Splits
vim.keymap.set('n', '|', ':vsplit<CR>')
vim.keymap.set('n', '\\', ':split<CR>')

-- Tabs
vim.keymap.set('n', '<Tab>', ':BufferLineCycleNext<CR>')
vim.keymap.set('n', '<s-Tab>', ':BufferLineCyclePrev<CR>')
vim.keymap.set('n', '<Leader>x', ':BufferLinePickClose<CR>')
vim.keymap.set('n', '<c-x>', ':BufferLineCloseOthers<CR>')

-- Git (fugitive): свой git-сервер и GitHub — одинаково (remote в .git/config)
vim.keymap.set('n', '<leader>gs', ':Git<CR>', { desc = 'Git status' })
vim.keymap.set('n', '<leader>gc', ':Git commit<CR>', { desc = 'Git commit' })
vim.keymap.set('n', '<leader>gp', ':Git push<CR>', { desc = 'Git push' })
vim.keymap.set('n', '<leader>gP', ':Git pull<CR>', { desc = 'Git pull' })
vim.keymap.set('n', '<leader>gb', ':Git blame<CR>', { desc = 'Git blame' })
vim.keymap.set('n', '<leader>gl', ':Flog<CR>', { desc = 'Git история (граф)' })

-- База данных: <leader>db — :DBUI (см. lua/plugins/dadbod.lua)
-- Локальная история версий: <leader>fu — telescope-undo (см. lua/plugins/undo.lua)
