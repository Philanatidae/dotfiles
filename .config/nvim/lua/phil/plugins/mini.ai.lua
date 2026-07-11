return {
    'nvim-mini/mini.ai',
    version = false,
    lazy = true,
    event = 'VeryLazy',
    config = function()
        local ai = require('mini.ai')

        ai.setup({
            custom_textobjects = {
                f = ai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }),
                c = ai.gen_spec.treesitter({ a = '@class.outer', i = '@class.inner' }),
            },
            n_lines = 500,
        })
    end,
}
