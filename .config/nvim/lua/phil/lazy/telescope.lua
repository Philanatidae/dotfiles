return {
    "nvim-telescope/telescope.nvim",
    cond = not vim.g.vscode,
    dependencies = {
        "nvim-lua/plenary.nvim"
    },
    config = function()
        require('telescope').setup({})

        local builtin = require('telescope.builtin')
        -- Future reference: https://github.com/ThePrimeagen/neovimrc/blob/master/lua/theprimeagen/lazy/telescope.lua
        vim.keymap.set('n', '<leader>s', builtin.find_files, {})
        vim.keymap.set('n', '<leader>S', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end)
        vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
    end
}
