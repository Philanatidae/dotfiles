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
        -- Macro recording indicator is shown in the heirline statusline
    },
}
