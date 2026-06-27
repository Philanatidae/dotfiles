vim.g.mapleader = ' '

-- Disable middle-click paste
vim.keymap.set({ 'n', 'i', 'v' }, '<MiddleMouse>', '<Nop>')
vim.keymap.set({ 'n', 'i', 'v' }, '<2-MiddleMouse>', '<Nop>')
vim.keymap.set({ 'n', 'i', 'v' }, '<3-MiddleMouse>', '<Nop>')
vim.keymap.set({ 'n', 'i', 'v' }, '<4-MiddleMouse>', '<Nop>')

vim.keymap.set('n', '<leader>w', '<cmd>update<CR>', { desc = "Write buffer" })
vim.keymap.set('n', '<leader>W', '<cmd>bufdo update<CR>', { desc = "Write all buffers" })
vim.keymap.set('n', '<leader><C-q>', '<cmd>qa<CR>', { desc = 'Quit Neovim' })
-- These two will be overridden by vim-wintabs if it's enabled
vim.keymap.set('n', '<leader>q', '<cmd>bd<CR>', { desc = 'Close current buffer' })
vim.keymap.set('n', '<leader>Q', '<cmd>q<CR>', { desc = 'Close current window' })

-- Window management
for _, key in ipairs({ 'h', 'j', 'k', 'l' }) do
    vim.keymap.set('n', '<leader>' .. key,
        (":<C-u>exe ':wincmd ' . v:count1 . '%s'<CR>"):format(key),
        {
            silent = true,
            desc = ('Go to the %s window'):format(key),
        })
end

-- Diagnostics
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open diagnostic window' })

-- @todo Do I need these anymore?
-- vim.keymap.set('i', '<C-c>', '<Nop>')
-- vim.keymap.set('v', '<C-c>', '<Nop>')
-- vim.keymap.set('n', 'U', '<C-r>', { desc = 'Redo', })

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move line down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move line up' })

vim.keymap.set('n', 'J', 'mzJ`z', { desc = 'Join lines at cursor' })

vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Scroll down' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Scroll up' })
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Next search result' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Previous search result' })
