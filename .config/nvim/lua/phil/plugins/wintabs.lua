return {
    dir = '/Users/philiprader/Developer/Git/wintabs.nvim/',
    enabled = true,
    lazy = false,
    dependencies = {
    },
    opts = {},
    keys = {
        {
            '<leader>[',
            function()
                require('wintabs').prev()
            end,
            desc = 'Previous window tab',
        },
        {
            '<leader>]',
            function()
                require('wintabs').next()
            end,
            desc = 'Next window tab',
        },
        {
            '<leader>q',
            function()
                require('wintabs').close()
            end,
            desc = 'Close window tab',
        },
        {
            '<leader>Q',
            function()
                require('wintabs').close_window()
            end,
            desc = 'Close window',
        },
        {
            '<leader>O',
            function()
                require('wintabs').only()
            end,
            desc = 'Close all tabs except the active tab',
        },

        {
            '<leader>L',
            function()
                require('wintabs').move_to_window('l')
            end,
            desc = 'Move tab to the window to the right',
        },
        {
            '<leader>H',
            function()
                require('wintabs').move_to_window('h')
            end,
            desc = 'Move tab to the window to the left',
        },
        {
            '<leader>K',
            function()
                require('wintabs').move_to_window('k')
            end,
            desc = 'Move tab to the window above',
        },
        {
            '<leader>J',
            function()
                require('wintabs').move_to_window('j')
            end,
            desc = 'Move tab to the window below',
        },

        {
            '<leader><C-l>',
            function()
                vim.cmd('silent vnew')
                vim.cmd('silent wincmd p')
                require('wintabs').move_to_window('l')
            end,
            desc = 'Move tab to the window to the right',
        },
        {
            '<leader><C-h>',
            function()
                vim.cmd('silent leftabove vnew')
                vim.cmd('silent wincmd p')
                require('wintabs').move_to_window('h')
            end,
            desc = 'Move tab to the window to the right',
        },
        {
            '<leader><C-k>',
            function()
                vim.cmd('silent leftabove new')
                vim.cmd('silent wincmd p')
                require('wintabs').move_to_window('k')
            end,
            desc = 'Move tab to the window above',
        },
        {
            '<leader><C-j>',
            function()
                vim.cmd('silent new')
                vim.cmd('silent wincmd p')
                require('wintabs').move_to_window('j')
            end,
            desc = 'Move tab to the window below',
        },
    }
}
