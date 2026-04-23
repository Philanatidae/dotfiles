return {
    'olimorris/codecompanion.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim'
    },
    opts = {
        -- adapters = {
        --     acp = {
        --         gemini-cli =
        --     },
        -- },
        interactions = {
            chat = {
                adapter = 'gemini_cli',
            },
        },
    },
}
