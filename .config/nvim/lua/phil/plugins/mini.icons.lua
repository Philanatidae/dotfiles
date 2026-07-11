return {
    'nvim-mini/mini.icons',
    verion = '*',
    lazy = true,
    optional = true,
    specs = {
        { 'nvim-tree/nvim-web-devicons', enabled = false, optional = true, }
    },
    init = function()
        package.preload['nvim-web-devicons'] = function()
            require('mini.icons').mock_nvim_web_devicons()
            return package.loaded['nvim-web-devicons']
        end
    end,
}
