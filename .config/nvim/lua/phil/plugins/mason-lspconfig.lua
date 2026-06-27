return {
    'mason-org/mason-lspconfig.nvim',
    dependencies = {
        'mason-org/mason.nvim',
        'neovim/nvim-lspconfig',
    },
    enabled = true,
    lazy = true,
    event = { 'BufReadPre', 'BufNewFile' },
    cond = not vim.g.vscode,
    opts = {
    },
}
