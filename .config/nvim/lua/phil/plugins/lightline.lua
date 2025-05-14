return {
    "itchyny/lightline.vim",
    enabled = false,
    lazy = false,
    priority = 100,
    dependencies = {
        "nvim-tree/nvim-web-devicons",

        "josa42/nvim-lightline-lsp",
        "nvim-lua/lsp-status.nvim",
    },
    config = function()
        vim.opt.showmode = false -- Lightline shows mode, so we don't need this in the command section

        function _G.DevIconsFiletype()
            local devicons = require('nvim-web-devicons')
            local ft = vim.bo.filetype
            if ft == '' then return '' end
            local icon = devicons.get_icon_by_filetype(ft, { default = true })
            return ft .. ' ' .. (icon or '')
        end

        vim.cmd([[
                    let s:palette = v:lua.require('phil.lightline.colorscheme.nightowl')
                    let g:lightline#colorscheme#nightowl#palette = lightline#colorscheme#fill(s:palette)
                ]])

        vim.g.lightline = {
            colorscheme = "nightowl",
            enable = {
                statusline = 0, -- Wintabs will handle rendering
                tabline = 0,
            },
            component = {
                relativepath = "%f",
                time = "%{strftime('%l:%M %p')}",
            },
            component_function = {
                filetype = 'v:lua.DevIconsFiletype',
            },
            active = {
                left = {
                    { "mode",         "paste" },
                    { "lsp_warnings", "lsp_errors", "lsp_ok" },
                },
                right = {
                    { "lineinfo" },
                    { "percent" },
                    { "time" },
                    { "readonly" },
                    { "filetype" },
                    { "relativepath" },
                },
            },
            inactive = {
                left = {
                    { "filename" },
                },
                right = {
                    { "lineinfo" },
                    { "percent" },
                },
            },
            tabline = {
                left = {
                    { 'tabs' }
                },
                right = {
                    { 'close' }
                }
            },
        }

        vim.cmd("call lightline#lsp#register()") -- Register LSP components
    end
}
