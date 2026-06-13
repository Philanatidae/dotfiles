return {
    'nvim-lualine/lualine.nvim',
    enabled = false,
    lazy = false,
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },
    config = function()
        local function generate_hydra_theme(hydra_color)
            local base_theme = require('lualine.themes.auto')

            return {
                normal = {
                    a = { fg = '#ffffff', bg = hydra_color, bold = true },
                    b = { fg = hydra_color, bg = '#303030' },
                    c = { fg = '#ffffff', bg = '#202020' },
                },
                inactive = base_theme.inactive
            }
        end
        local function get_current_theme()
            local ok, hydra = pcall(require, 'hydra.statusline')
            if ok and hydra.is_active() then
                local hydra_color = hydra.get_color() or '#ff5f5f'
                return generate_hydra_theme(hydra_color)
            end
            return 'auto'
        end
        local function get_mode_with_hydra()
            local ok, hydra = pcall(require, 'hydra.statusline')
            if ok and hydra.is_active() then
                return hydra.get_name() or 'HYDRA'
            end
            return require('lualine.utils.mode').get_mode()
        end

        local function devicons_filetype()
            local devicons = require('nvim-web-devicons')
            local ft = vim.bo.filetype
            if ft == '' then return '' end
            local icon = devicons.get_icon_by_filetype(ft, { default = true })
            return ft .. ' ' .. (icon or '')
        end
        local function time()
            return '%{strftime(\'%l:%M %p\')}'
        end
        local function lsp_inactive_status()
            local buf_clients = vim.lsp.get_clients({ bufnr = 0 })
            if next(buf_clients) == nil then
                return 'LSP Inactive'
            end
            return ''
        end
        local function dap_ui_status()
            if vim.g.dapui_enabled then
                return 'DEBUG'
            end
            return ''
        end

        local function setup_lualine()
            require('lualine').setup {
                options = {
                    icons_enabled = true,
                    theme = get_current_theme(),
                    component_separators = { left = '', right = '' },
                    section_separators = { left = '', right = '' },
                    disabled_filetypes = {
                        statusline = {},
                        winbar = {},
                    },
                    always_divide_middle = true,
                    always_show_tabline = false,
                    globalstatus = true,
                    refresh = {
                        -- Wintabs will handle rendering
                        -- @todo Have this re-enable when wintabs is disabled
                        statusline = 0,
                        tabline = 0,
                        winbar = 0,
                    }
                },
                sections = {
                    -- +-------------------------------------------------+
                    -- | A | B | C                             X | Y | Z |
                    -- +-------------------------------------------------+
                    lualine_a = {
                        -- 'mode',
                        {
                            get_mode_with_hydra,
                            color = get_mode_color_bg,
                        }
                    },
                    lualine_b = {
                        -- @todo I really don't like the way that dap is shown in the bar
                        {
                            dap_ui_status,
                            color = { fg = '#ffffff', bg = '#008000' },
                            cond = function() return vim.g.dapui_enabled end,
                            separator = '',
                            padding = { left = 1, right = 1 },
                        },
                        'lsp_status',
                        lsp_inactive_status,
                    },
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
            require('lualine').hide()
        end

        setup_lualine()

        local hydra_augroup = vim.api.nvim_create_augroup("LualineHydraTracker", { clear = true })
        vim.api.nvim_create_autocmd("User", {
            pattern = { "HydraEnter", "HydraExit" },
            group = hydra_augroup,
            callback = setup_lualine,
        })
    end
}
