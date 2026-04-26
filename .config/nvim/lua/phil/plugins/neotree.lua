return {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    enabled = true,
    lazy = false, -- Neotree lazy loads itself apparently
    dependencies = {
        'nvim-lua/plenary.nvim',
        'MunifTanjim/nui.nvim',
        '3rd/image.nvim',
        'nvim-tree/nvim-web-devicons',
    },
    cond = not vim.g.vscode,
    cmd = 'Neotree',
    keys = {
        {
            '<C-t>',
            '<cmd>Neotree toggle<CR>',
            desc = 'Open file tree'
        },
        {
            '<leader>t',
            '<cmd>Neotree reveal<CR>',
            desc = 'Reveal current file in file tree'
        },
    },
    config = true,
    opts = {
        event_handlers = {
            {
                event = 'neo_tree_buffer_enter',
                handler = function()
                    vim.cmd([[
                        setlocal number
                      setlocal relativenumber
                    ]])
                end,
            },
        },
    },
}
