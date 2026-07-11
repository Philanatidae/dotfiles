return {
    'arborist-ts/arborist.nvim',
    enabled = true,
    lazy = true,
    event = 'VeryLazy',
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
