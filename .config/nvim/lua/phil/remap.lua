vim.g.mapleader = ' '

if (vim.g.vscode) then
    local vscode = function(cmd)
        require('vscode-neovim').call(cmd)
    end

    vim.keymap.set('n', '<leader>w', function()
        vscode('workbench.action.files.save')
    end)
    vim.keymap.set('n', '<leader>W', function()
        vscode('workbench.action.files.saveAll')
    end)
    vim.keymap.set('n', '<leader><C-q>', function()
        vscode('workbench.action.closeAllEditors')
    end)

    -- These don't work correctly (specifically, =, which
    -- has something else bound do it =?, I've got no idea
    -- what). This works in neovim proper, but not in vscode.
    -- Oh well, screw that for now.
    --
    -- Also need to add count arg
    -- vim.keymap.set('n', '=', function()
    --     vscode('workbench.action.increaseViewWidth')
    -- end)
    -- vim.keymap.set('n', '-', function()
    --     vscode('workbench.action.decreaseViewWidth')
    -- end)
    -- vim.keymap.set('n', '+', function()
    --     vscode('workbench.action.increaseViewHeight')
    -- end)
    -- vim.keymap.set('n', '_', function()
    --     vscode('workbench.action.decreaseViewHeight')
    -- end)

    vim.keymap.set('n', '<leader>l', ":<C-u>exe ':wincmd ' . v:count1 . 'l'<CR>")
    vim.keymap.set('n', '<leader>k', ":<C-u>exe ':wincmd ' . v:count1 . 'k'<CR>")
    vim.keymap.set('n', '<leader>j', ":<C-u>exe ':wincmd ' . v:count1 . 'j'<CR>")
    vim.keymap.set('n', '<leader>h', ":<C-u>exe ':wincmd ' . v:count1 . 'h'<CR>")
else
    vim.keymap.set('n', '<leader>w', '<cmd>update<CR>', { desc = "Write buffer" })
    vim.keymap.set('n', '<leader>W', '<cmd>bufdo update<CR>', { desc = "Write all buffers" })
    vim.keymap.set('n', '<leader><C-q>', function()
        vim.cmd('qa')
    end, { desc = 'Quit Neovim' })

    -- Window management
    vim.keymap.set('n', '=', ":<C-u>exe 'vertical resize +' . v:count1<CR>", { desc = "Increase window height" })
    vim.keymap.set('n', '-', ":<C-u>exe 'vertical resize -' . v:count1<CR>", { desc = "Decrease window height" })
    vim.keymap.set('n', '+', ":<C-u>exe 'resize +' . v:count1<CR>", { desc = 'Increase window width' })
    vim.keymap.set('n', '_', ":<C-u>exe 'resize -' . v:count1<CR>", { desc = 'Decrease window width' })

    vim.keymap.set('n', '<leader>l', ":<C-u>exe ':wincmd ' . v:count1 . 'l'<CR>",
        { desc = 'Move cursor to right window' })
    vim.keymap.set('n', '<leader>k', ":<C-u>exe ':wincmd ' . v:count1 . 'k'<CR>",
        { desc = 'Move cursor to above window' })
    vim.keymap.set('n', '<leader>j', ":<C-u>exe ':wincmd ' . v:count1 . 'j'<CR>",
        { desc = 'Move cursor to below window' })
    vim.keymap.set('n', '<leader>h', ":<C-u>exe ':wincmd ' . v:count1 . 'h'<CR>",
        { desc = 'Move cursor to left window' })

    -- Diagnostics
    vim.keymap.set('n', '<leader>e', function() vim.diagnostic.open_float() end, { desc = 'Open diagnostic window' })

    vim.keymap.set('i', '<C-c>', '<Nop>')
    vim.keymap.set('v', '<C-c>', '<Nop>')

    vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move line down' })
    vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move line up' })

    vim.keymap.set('n', 'J', 'mzJ`z', { desc = 'Join lines at cursor' })

    vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Scroll down' })
    vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Scroll up' })
    vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Next search result' })
    vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Previous search result' })
end

vim.keymap.set('n', 'U', function()
    vim.cmd('redo')
end, { desc = 'Redo', })
