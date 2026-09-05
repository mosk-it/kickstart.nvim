vim.keymap.set('n', '<C-p>', ':bp<CR>', { desc = '' })
vim.keymap.set('n', '<C-n>', ':bn<CR>', { desc = '' })

vim.keymap.set('n', 'k', 'gk', { desc = 'Move one visible line up' })
vim.keymap.set('n', 'j', 'gj', { desc = 'Move one visible line down' })

vim.keymap.set('n', 'gp', '"*p', { desc = 'Paste from primary clipboard' })
vim.keymap.set('n', 'gy', '"*y', { desc = 'Copy to primary clipboard' })

vim.keymap.set('n', '<C-s>', ':w<CR>', { desc = 'save' })

vim.keymap.set('n', '<leader>-', '<cmd>lua MiniFiles.open()<CR>', { desc = 'Open MiniFiles' })

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

vim.keymap.set("n", "<c-q>", function() require("mini.bufremove").delete(0) end)

vim.keymap.set('c', '<C-e>', '<End>', { desc = '', remap = true })

vim.keymap.set('n', '<C-b>', '15<C-Y>', { remap = true, silent = true })
vim.keymap.set('n', '<C-f>', '15<C-E>', { remap = true, silent = true })
vim.keymap.set('n', 'q:', '<nop>')

vim.api.nvim_create_user_command('W', function()
  vim.cmd('w suda://' .. vim.fn.expand '%')
end, {
  desc = 'Write current file with sudo privileges',
})



vim.keymap.set('n', '<Tab>',   'zo', { silent = true })
vim.keymap.set('n', '<S-Tab>', 'zc', { silent = true })

vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)


local ufo = require('ufo')

-- Helper function to get the current fold under the cursor
local function get_current_fold()
    local bufnr = vim.api.nvim_get_current_buf()
    local winid = vim.api.nvim_get_current_win()
    local line = vim.api.nvim_win_get_cursor(winid)[1]
    local folds = ufo.getFolds(bufnr, winid)
    for _, fold in ipairs(folds) do
        if line >= fold.startLine and line <= fold.endLine then
            return fold
        end
    end
    return nil
end

-- Open the current fold if it's closed
local function open_current_fold()
    if vim.fn.foldclosed('.') ~= -1 then
        vim.cmd('normal! zo')
    end
end

-- Close the current fold if it's open
local function close_current_fold()
    if vim.fn.foldclosed('.') == -1 then
        vim.cmd('normal! zc')
    end
end

-- Toggle the current fold (open if closed, close if open)
local function toggle_current_fold()
    vim.cmd('normal! za')
end

-- Keybindings
vim.keymap.set('n', 'zo', open_current_fold, { desc = 'Open current fold' })
vim.keymap.set('n', 'zc', close_current_fold, { desc = 'Close current fold' })
vim.keymap.set('n', 'za', toggle_current_fold, { desc = 'Toggle current fold' })
vim.keymap.set('n', 'q:', '<nop>', { noremap = true, silent = true })

vim.keymap.set('v', 'r', '"_dP', { noremap = true, silent = true })

vim.keymap.set('n', '<leader>yp', ":let @+=expand('%:.')<cr>", { desc = "Copy buffer's relative path" })
vim.keymap.set('n', '<leader>yP', function()
  vim.fn.setreg('+', vim.fn.expand('%:p'))
end, { desc = "Copy buffer's absolute path" })

return {}
