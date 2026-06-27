return {
    'philanatidae/vim-wintabs',
    enabled = true,
    lazy = false, -- This isn't a nvim plugin, can't lazy load
    init = function()
        -- When closing the last tab in the window, keep the window
        -- active. Pressing <leader>q again will close the window.
        vim.g.wintabs_autoclose = 1

        vim.g.wintabs_display = 'winbar'
        vim.g.wintabs_ui_active_higroup = 'WinbarActive'
    end,
    config = function()
        local visual_bg = vim.api.nvim_get_hl(0, { name = 'Visual' }).bg
        local normal_fg = vim.api.nvim_get_hl(0, { name = 'Normal' }).fg
        vim.api.nvim_set_hl(0, 'WinbarActive', { fg = normal_fg, bg = visual_bg, bold = true })
    end,
    keys = {
        -- @todo Decide if these two should be replaced with ]b & [b
        {
            '<leader>]',
            '<cmd>WintabsNext<CR>',
            desc = 'Switch to next window tab',
        },
        {
            '<leader>[',
            '<cmd>WintabsPrevious<CR>',
            desc = 'Switch to previous window tab',
        },
        -- Trying out [b and ]b
        {
            ']b',
            '<cmd>WintabsNext<CR>',
            desc = 'Switch to next window tab',
        },
        {
            '[b',
            '<cmd>WintabsPrevious<CR>',
            desc = 'Switch to previous window tab',
        },

        {
            '<leader>q',
            '<cmd>WintabsClose<CR>',
            desc = 'Close window tab',
        },
        {
            '<leader>Q',
            '<cmd>WintabsCloseWindow<CR>',
            desc = 'Close window',
        },

        {
            '<leader>O',
            '<cmd>WintabsOnly<CR>',
            desc = 'Close all tabs except the active tab',
        },

        {
            '<leader><C-l>',
            function()
                vim.cmd('silent vnew | wincmd p | WintabsMoveToWindow l')
            end,
            desc = 'Move tab to new window on the right',
        },
        {
            '<leader><C-h>',
            function()
                vim.cmd('silent leftabove vnew | wincmd p | WintabsMoveToWindow h')
            end,
            desc = 'Move tab to new window on the left',
        },
        {
            '<leader><C-k>',
            function()
                vim.cmd('silent leftabove new | wincmd p | WintabsMoveToWindow k')
            end,
            desc = 'Move tab to new window on the top',
        },
        {
            '<leader><C-j>',
            function()
                vim.cmd('silent new | wincmd p | WintabsMoveToWindow j')
            end,
            desc = 'Move tab to new window on the bottom',
        },

        {
            '<leader>L',
            '<cmd>WintabsMoveToWindow l<CR>',
            desc = 'Move tab to the window on the right',
        },
        {
            '<leader>H',
            '<cmd>WintabsMoveToWindow h<CR>',
            desc = 'Move tab to the window on the left',
        },
        {
            '<leader>K',
            '<cmd>WintabsMoveToWindow k<CR>',
            desc = 'Move tab to the window above',
        },
        {
            '<leader>J',
            '<cmd>WintabsMoveToWindow j<CR>',
            desc = 'Move tab to the window below',
        },
    },
}
