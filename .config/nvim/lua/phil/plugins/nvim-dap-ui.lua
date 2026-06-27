return {
    'rcarriga/nvim-dap-ui',
    enabled = true,
    dependencies = {
        'mfussenegger/nvim-dap',
        'nvim-neotest/nvim-nio',
    },
    lazy = true,
    -- @todo This needs to be rewritten
    keys = function()
        return {
            {
                '<leader>D',
                function()
                    require('dapui').toggle()
                    if not vim.g.dapui_enabled then
                        vim.g.dapui_enabled = true
                    else
                        vim.g.dapui_enabled = not vim.g.dapui_enabled
                    end
                end,
                desc = 'Toggle debug ui'
            },
            {
                '<leader>dK',
                function()
                    if require('dap').session() ~= nil then
                        require('dapui').eval()
                    end
                end,
                desc = 'Inspect variable (debug)'
            },
        }
    end,
    opts = {},
}
