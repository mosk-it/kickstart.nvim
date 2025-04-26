vim.keymap.set('n', '<C-p>', ':bp<CR>', { desc = '' })
vim.keymap.set('n', '<C-n>', ':bn<CR>', { desc = '' })

vim.keymap.set('n', 'k', 'gk', { desc = 'Move one visible line up' })
vim.keymap.set('n', 'j', 'gj', { desc = 'Move one visible line down' })

vim.keymap.set('n', 'gp', '"*p', { desc = 'Paste from primary clipboard' })
vim.keymap.set('n', 'gy', '"*y', { desc = 'Copy to primary clipboard' })

vim.keymap.set('n', '<C-s>', ':w<CR>', { desc = 'save' })

vim.keymap.set('c', '<C-p>', '<Up>', { desc = '' })
vim.keymap.set('c', '<C-n>', '<Down>', { desc = '' })
vim.keymap.set('c', '<C-a>', '<Home>', { desc = '' })
vim.keymap.set('c', '<C-b>', '<Left>', { desc = '' })
vim.keymap.set('c', '<C-f>', '<Right>', { desc = '' })
vim.keymap.set('c', '<C-d>', '<Delete>', { desc = '' })
vim.keymap.set('c', '<M-b>', '<S-Left>', { desc = '' })
vim.keymap.set('c', '<M-f>', '<S-Right>', { desc = '' })
vim.keymap.set('c', '<M-d>', '<S-right><Delete>', { desc = '' })
vim.keymap.set('c', '<Esc>b', '<S-Left>', { desc = '' })
vim.keymap.set('c', '<Esc>f', '<S-Right>', { desc = '' })
vim.keymap.set('c', '<Esc>d', '<S-right><Delete>', { desc = '' })
vim.keymap.set('c', '<C-g>', '<C-c>', { desc = '' })

vim.keymap.set('c', '<C-g>', '<C-c>', { desc = '' })
vim.keymap.set('i', '<C-a>', '<C-O>^', { desc = '' })
vim.keymap.set('i', '<C-e>', '<C-O>$', { desc = '' })
vim.keymap.set('i', '<C-f>', '<C-O>l', { desc = '' })
vim.keymap.set('i', '<C-b>', '<C-O>h', { desc = '' })

vim.keymap.set('c', '<C-e>', '<End>', { desc = '', remap = true })

vim.keymap.set('n', '<C-b>', '15<C-Y>', { remap = true, silent = true })
vim.keymap.set('n', '<C-f>', '15<C-E>', { remap = true, silent = true })
vim.keymap.set('n', 'q:', '<nop>')

vim.api.nvim_create_user_command('W', function()
  vim.cmd('w suda://' .. vim.fn.expand '%')
end, {
  desc = 'Write current file with sudo privileges',
})

-- vim.keymap.set('n', '<C-b>', '15<C-Y>')
-- vim.keymap.set('n', '<C-f>', '15<C-K>')

return {}
