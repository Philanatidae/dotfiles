return {
    'mason-org/mason-lspconfig.nvim',
    dependencies = {
        'mason-org/mason.nvim',
        'neovim/nvim-lspconfig',
    },
    enabled = true,
    lazy = false,
    cond = not vim.g.vscode,
    config = function()
        require("mason-lspconfig").setup({
            ensure_installed = {
                'clangd',
                'lua_ls',
                'cmake',
                'html',
                'pylsp',
            },
            automatic_enable = true,
       })
    end
}
