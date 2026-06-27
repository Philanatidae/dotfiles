return {
    'mason-org/mason.nvim',
    enabled = true,
    lazy = false, -- Not recommended to lazy load according to README
    cond = not vim.g.vscode,
    config = function()
        require('mason').setup({})
    end
}
