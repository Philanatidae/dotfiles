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
        -- @todo I might not even need this anymore, can't I just manually install LSPs that I need?
        require("mason-lspconfig").setup({
            ensure_installed = {
                -- 'asm-lsp', Incorrect name, need to rethink this
                'clangd',
                'lua_ls',
                'cmake',
                'html',
                'pylsp',
                'jsonls',
                'cssls',
                'eslint',
                'ts_ls',
                'gopls',
            },
            automatic_enable = true,
       })
    end
}
