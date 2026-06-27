return {
    'stevearc/conform.nvim',
    enabled = true,
    lazy = true,
    event = 'BufWritePre',
    cmd = {
        'ConformInfo'
    },
    keys = {
        {
            '<leader>f',
            function()
                require("conform").format({ async = true })
            end,
            desc = 'Format buffer',
        },
    },
    -- This will provide type hinting with LuaLS
    ---@module "conform"
    ---@type conform.setupOpts
    opts = {
    },
    init = function()
        vim.o.formatexpr = 'v:lua.require\'conform\'.formatexpr()'
    end,
}
