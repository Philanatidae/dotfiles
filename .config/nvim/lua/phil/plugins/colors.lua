local ColorSchemes = {
    NIGHT_OWL = 1,
    TOKYO_NIGHT = 2,
}

local colorscheme = ColorSchemes.TOKYO_NIGHT

if (colorscheme == ColorSchemes.NIGHT_OWL) then
    return {
        'Philanatidae/night-owl.nvim',
        enabled = true,
        lazy = false,
        cond = not vim.g.vscode,
        priority = 1000,
        config = function()
            -- @todo Add light theme
            require('night-owl').setup()
            vim.cmd('colorscheme night-owl')
        end
    }
end
if (colorscheme == ColorSchemes.TOKYO_NIGHT) then
    return {
        'folke/tokyonight.nvim',
        enabled = true,
        lazy = false,
        cond = not vim.g.vscode,
        priority = 1000,
        config = function()
            require('tokyonight').setup()
            vim.cmd('colorscheme tokyonight')
        end
    }
end
