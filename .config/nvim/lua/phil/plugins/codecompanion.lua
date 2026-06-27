return {
    'olimorris/codecompanion.nvim',
    enabled = true,
    cmd = {
        'CodeCompanion',
        'CodeCompanionChat',
        'CodeCompanionCmd',
        'CodeCompanionActions',
    },
    keys = {
        { '<leader>cc', '<cmd>CodeCompanionChat toggle<cr>', desc = 'AI Chat',    mode = { 'n', 'v' }, },
        -- @todo This interferes with "code-actions"
        -- { '<leader>ca', '<cmd>CodeCompanionActions<cr>',     desc = 'AI Actions', mode = { 'n', 'v' }, },
    },
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-treesitter/nvim-treesitter',
        'lalitmee/codecompanion-spinners.nvim',
    },
    opts = {
        extensions = {
            spinner = {
                opts = {
                    style = 'cursor-relative',
                },
            },
        },
        display = {
            chat = {
                window = {
                    layout = 'vertical',
                    width = 0.3,
                },
            },
        },
        interactions = {
            chat = {
                adapter = 'claude_code',
            },
        },
    },
}
