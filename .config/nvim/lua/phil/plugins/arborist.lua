return {
    'arborist-ts/arborist.nvim',
    enabled = true,
    lazy = true,
    event = 'VeryLazy',
    dependencies = {
        { 'nvim-treesitter/nvim-treesitter-textobjects', branch = 'main' }
    },
    opts = {
        install_popular = false,
        ensure_installed = {
            'markdown',
            'markdown_inline',
            'html',
            'yaml',
            'bash',
            'regex',
        },
    },
}
