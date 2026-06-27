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
                require("conform").format({
                    async = true,
                    lsp_format = 'fallback'
                })
            end,
            desc = 'Format buffer',
        },
    },
    ---@module "conform"
    ---@type conform.setupOpts
    opts = {
        formatters_by_ft = {
            lua = { 'stylua' },
            -- python = { 'isort', 'black' },
            -- javascript = { 'prettierd', 'prettier', stop_after_first = true },
            -- add the filetypes you actually work with
        },
        format_on_save = {
            timeout_ms = 500,
            lsp_format = 'fallback',
        },
    },
    init = function()
        vim.o.formatexpr = 'v:lua.require\'conform\'.formatexpr()'
    end,
}
