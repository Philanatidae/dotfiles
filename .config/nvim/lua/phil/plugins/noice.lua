return {
    'folke/noice.nvim',
    enabled = true,
    lazy = true,
    event = 'VeryLazy',
    dependencies = {
        'MunifTanjim/nui.nvim',
    },
    opts = {
        lsp = {
            progress = {
                enabled = false,
            },
        },
        -- @todo There's no indication of macros recording.
        -- routes = {
        --     {
        --         filter = {
        --             event = 'msg_showmode',
        --         },
        --         view = 'mini',
        --     },
        -- }
    },
}
