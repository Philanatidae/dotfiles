return {
    'https://gitlab.com/HiPhish/rainbow-delimiters.nvim',
    enabled = true,
    lazy = true,
    event = { 'BufReadPost', 'BufNewFile' },
    cond = not vim.g.vscode,
    config = function()
        require('rainbow-delimiters.setup').setup {}
    end
}
