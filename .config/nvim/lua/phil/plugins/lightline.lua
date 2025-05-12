return {
    "itchyny/lightline.vim",
    enabled = true,
    lazy = false,
    cond = not vim.g.vscode,
    priority = 100,
    dependencies = {
        "ryanoasis/vim-devicons",

        "josa42/nvim-lightline-lsp",
        "nvim-lua/lsp-status.nvim",
    },
    config = function()
        vim.opt.showmode = false -- Lightline shows mode, so we don't need this in the command section

        vim.cmd([[
                    function! DevIconsFiletype()
                        return strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : ''
                    endfunction
                ]])

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
                filetype = 'DevIconsFiletype',
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
