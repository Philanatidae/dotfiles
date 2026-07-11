return {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    enabled = true,
    lazy = true,
    event = "VeryLazy",
    opts = {
    },
    init = function()
        vim.g.no_plugin_maps = true
    end,
}
