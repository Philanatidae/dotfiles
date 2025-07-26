return {
    'mfussenegger/nvim-dap',
    enabled = true,
    lazy = true,
    keys = function()
        return {
            {
                '<leader>b',
                '<cmd>DapToggleBreakpoint<CR>',
                'Toggle breakpoint',
            },

            {
                '<F5>',
                '<cmd>DapContinue<CR>',
                'Debug Start/Continue',
            },
            {
                '<S-F5>',
                '<cmd>DapTerminate<CR>',
                'Debug Stop',
            },
            {
                '<F6>',
                '<cmd>DapStepOver<CR>',
                'Debug Step Over',
            },
            {
                '<F7>',
                '<cmd>DapStepInto<CR>',
                'Debug Step In',
            },
            {
                '<F8>',
                '<cmd>DapStepOut<CR>',
                'Debug Step Out',
            },
        }
    end,
    config = function()
        vim.fn.sign_define('DapBreakpoint', {text='●', texthl='DiagnosticError', linehl='', numhl=''})
        vim.fn.sign_define('DapBreakpointCondition', {text='', texthl='DiagnosticError', linehl='', numhl=''})
        vim.fn.sign_define('DapLogPoint', {text='', texthl='', linehl='DiagnosticError', numhl=''})
        vim.fn.sign_define('DapStopped', {text='', texthl='', linehl='DiagnosticError', numhl=''})
        vim.fn.sign_define('DapBreakpointRejected', {text='R', texthl='DiagnosticError', linehl='', numhl=''})

        local dap = require('dap')

        -- https://github.com/mfussenegger/nvim-dap/wiki/C-C---Rust-(via--codelldb)
        dap.adapters.codelldb = {
            type = 'executable',
            command = 'codelldb', -- Must be in path

            -- On windows you may have to uncomment this:
            -- detatched = false
        }

        -- dap.configurations.cpp = {
        --     -- {
        --     --     name = "Launch File",
        --     --     type = "codelldb",
        --     --     request = "launch",
        --     --     program = function()
        --     --         return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        --     --     end,
        --     --     cwd = '${workspaceFolder}',
        --     --     stopOnEntry = false,
        --     -- }
        -- }
        -- dap.configurations.c = dap.configurations.cpp
        -- dap.configurations.objc = dap.configurations.cpp
        -- dap.configurations.objcpp = dap.configurations.cpp
        -- dap.configurations.rust = dap.configurations.cpp
    end
}

