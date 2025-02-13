return {
    "https://gitlab.com/HiPhish/rainbow-delimiters.nvim",
    enabled = true,
    lazy = false,
    cond = not vim.g.vscode,
    config = function()
        require('rainbow-delimiters.setup').setup {
            -- strategy = {
            --     -- ...
            -- },
            -- query = {
            --     -- ...
            -- },
            -- highlight = {
            --     -- ...
            -- },
        }
    end
}
