return {
    'rcarriga/nvim-dap-ui',
    enabled = true,
    dependencies = {
        "mfussenegger/nvim-dap",
        "nvim-neotest/nvim-nio",
    },
    lazy = true,
    keys = function()
        local dapui = require('dapui')

        return {
            {
                '<leader>D',
                function()
                    dapui.toggle()
                    if not vim.g.dapui_enabled then
                        vim.g.dapui_enabled = true
                    else
                        vim.g.dapui_enabled = not vim.g.dapui_enabled
                    end
                end,
                'Toggle debug ui (dap-ui)'
            },
            {
                '<leader>dK',
                function()
                    if require('dap').session() ~= nil then
                        require('dapui').eval()
                    end
                end,
            },
        }
    end,
    opts = {},
}
