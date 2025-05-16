-- I can't get this working with wintabs right now
return {
    "nvim-lualine/lualine.nvim",
    enabled = true,
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local function devicons_filetype()
            local devicons = require('nvim-web-devicons')
            local ft = vim.bo.filetype
            if ft == '' then return '' end
            local icon = devicons.get_icon_by_filetype(ft, { default = true })
            return ft .. ' ' .. (icon or '')
        end
        local function time()
            return "%{strftime('%l:%M %p')}"
        end
        local function lsp_inactive_status()
            local buf_clients = vim.lsp.get_clients({ bufnr = 0 })
            if next(buf_clients) == nil then
                return 'LSP Inactive'
            end
            return ''
        end

        require('lualine').setup {
            options = {
                icons_enabled = true,
                theme = 'auto',
                component_separators = { left = '', right = '' },
                section_separators = { left = '', right = '' },
                disabled_filetypes = {
                    statusline = {},
                    winbar = {},
                },
                always_divide_middle = true,
                always_show_tabline = false,
                globalstatus = false,
                refresh = {
                    -- Wintabs will handle rendering
                    statusline = 0,
                    tabline = 0,
                    winbar = 0,
                }
            },
            sections = {
                -- +-------------------------------------------------+
                -- | A | B | C                             X | Y | Z |
                -- +-------------------------------------------------+
                lualine_a = { 'mode', },
                lualine_b = { 'lsp_status', lsp_inactive_status, },
                lualine_c = { 'diagnostics', },

                lualine_x = { '%f', },
                lualine_y = { devicons_filetype },
                lualine_z = { 'readonly', time, 'location', }
            },
            -- inactive_sections = {
            --     lualine_a = {},
            --     lualine_b = {},
            --     lualine_c = { 'filename' },
            --     lualine_x = { 'location' },
            --     lualine_y = {},
            --     lualine_z = {}
            -- },
            tabline = {},
            extensions = {}
        }
    end
}
