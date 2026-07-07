return {
    'L3MON4D3/LuaSnip',
    version = 'v2.*',
    build = 'make install_jsregexp',
    enabled = true,
    lazy = true,
    event = 'VeryLazy',
    config = function()
        require('luasnip').setup({})

        -- require('luasnip.loaders.from_vscode').lazy_load()
        local loaded = {}
        vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile' }, {
            group = vim.api.nvim_create_augroup('LuaSnipSearch', { clear = true }),
            callback = function(args)
                local root = vim.fs.root(args.buf, '.git')
                if not root then return end
                local path = root .. '/.luasnippets'
                if loaded[path] or vim.fn.isdirectory(path) == 0 then return end
                require('luasnip.loaders.from_lua').load({ paths = { path } })
                loaded[path] = true
            end
        })
    end
}
