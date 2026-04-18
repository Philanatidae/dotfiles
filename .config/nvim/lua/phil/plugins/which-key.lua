return {
    'folke/which-key.nvim',
    enabled = true,
    lazy = true,
    event = 'VeryLazy',
    opts = {
        preset = 'classic',
    },
    keys = {
        {
            '<leader>?',
            function()
                require('which-key').show({ global = false })
            end,
            desc = 'Buffer Local Keymaps (which-key)',
        },
    },
}
