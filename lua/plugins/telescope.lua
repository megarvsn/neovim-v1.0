return {
	{
		'nvim-telescope/telescope.nvim', version = '*',
		dependencies = {
			'nvim-lua/plenary.nvim',
			-- optional but recommended
			{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
		},
		config = function()
			require('telescope').setup({})
			require('telescope').load_extension('undo')
			local builtin = require('telescope.builtin')
			vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Файлы (telescope)' })
			vim.keymap.set('n', '<leader>fw', builtin.live_grep, { desc = 'Поиск текста (telescope)' })
			vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Буферы (telescope)' })
			vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Помощь (telescope)' })
		end
	}
}
