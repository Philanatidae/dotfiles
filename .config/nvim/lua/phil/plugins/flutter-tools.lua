return {
    'nvim-flutter/flutter-tools.nvim',
    dependencies = {
        'nvim-telescope/telescope.nvim',
        'mfussenegger/nvim-dap',
    },
    enabled = true,
    -- This plugin lazy-loads by itself:
    -- https://github.com/nvim-flutter/flutter-tools.nvim/blob/d5bb1dc3db78d7ab65dd8c5a6f32a38e383b9cb1/lua/flutter-tools.lua#L77
    lazy = false,
    event = { 'BufEnter *.dart' },
    keys = {
        {
            '<leader>Fr',
            '<cmd>FlutterRun<CR>',
            desc = 'Run Flutter project',
        },
        {
            '<leader>FR',
            '<cmd>FlutterRestart<CR>',
            desc = 'Hot restart Flutter project',
        },
        {
            '<leader>Fq',
            '<cmd>FlutterQuit<CR>',
            desc = 'Quit Flutter project',
        },
        {
            '<leader>Fo',
            '<cmd>FlutterOutlineToggle<CR>',
            desc = 'Toggle Flutter widget outline',
        },
        {
            '<leader>SF',
            '<cmd>Telescope flutter commands<CR>',
            desc = 'Telescope Flutter',
        },
        {
            '<leader>Fs',
            '<cmd>Telescope flutter commands<CR>',
            desc = 'Telescope Flutter',
        },
    },
    config = function()
        require('flutter-tools').setup({
            dev_log = {
                enabled = true,
                filter = nil,
                notify_errors = false,
                open_cmd = 'tabedit', -- @todo Maybe floating window instead?
                focus_on_open = false,
            },
            debugger = {
                enabled = true,
            },
            widget_guides = {
                enabled = true,
            },
        })

        require('telescope').load_extension('flutter')
    end
}
