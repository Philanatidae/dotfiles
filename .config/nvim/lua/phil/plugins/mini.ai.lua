return {
    'nvim-mini/mini.ai',
    version = false,
    lazy = true,
    event = 'VeryLazy',
    config = function()
        local ai = require('mini.ai')

        local function ts_cover(captures)
            local spec = ai.gen_spec.treesitter(captures)
            return function(ai_type, id, opts)
                opts = vim.tbl_extend('force', opts or {}, { search_method = 'cover' })
                return spec(ai_type, id, opts)
            end
        end

        ai.setup({
            custom_textobjects = {
                f = ts_cover({ a = '@function.outer', i = '@function.inner' }),
            },
        })
    end,
}
