return {
    'saghen/blink.cmp',
    -- @todo provides snippets for the snippet source
    -- dependencies = { 'rafamadriz/friendly-snippets' },
    --
    -- use a release tag to download pre-built binaries
    version = '1.*',
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        'onsails/lspkind.nvim',
    },

    opts = {
        -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
        -- 'super-tab' for mappings similar to vscode (tab to accept)
        -- 'enter' for enter to accept
        -- 'none' for no mappings
        --
        -- All presets have the following mappings:
        -- C-space: Open menu or open docs if already open
        -- C-n/C-p or Up/Down: Select next/previous item
        -- C-e: Hide menu
        -- C-k: Toggle signature help (if signature.enabled = true)
        --
        -- See :h blink-cmp-config-keymap for defining your own keymap
        keymap = {
            preset = 'none',
            ['<C-Space>'] = { 'show', 'fallback', },
            ['<C-e>'] = { 'hide', 'fallback' },
            ['<CR>'] = { 'accept', 'fallback', },
            ['<Tab>'] = { 'select_next', 'fallback', },
            ['<S-Tab>'] = { 'select_prev', 'fallback', },
        },

        appearance = {
            -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
            -- Adjusts spacing to ensure icons are aligned
            nerd_font_variant = 'mono',
            kind_icons = {
                Copilot = '',
                Text = '',
                Method = '',
                Function = '󰊕',
                Constructor = '󰯲',

                Field = '',
                Variable = '󰆦',
                Property = '󰖷',

                Class = '',
                Interface = '',
                Struct = '',
                Module = '󰅩',

                Unit = '󰪚',
                Value = '󰦨',
                Enum = '',
                EnumMember = '',

                Keyword = '󰻾',
                Constant = '󰏿',

                Snippet = '󱄽',
                Color = '󰏘',
                File = '󰈔',
                Reference = '󰬲',
                Folder = '󰉋',
                Event = '󱐋',
                Operator = '󰪚',
                TypeParameter = '󰬛',
            },
        },

        signature = {
            enabled = true,
        },

        completion = {
            documentation = {
                auto_show = true
            },
            list = {
                selection = {
                    preselect = false,
                    auto_insert = false,
                },
            },
            menu = {
                draw = {
                    columns = {
                        { 'label', 'label_description', gap = 1, },
                        { 'kind_icon', 'kind', gap = 1 },
                    },
                    components = {
                        kind_icon = {
                            text = function(ctx)
                                local icon = ctx.kind_icon
                                if vim.tbl_contains({ 'Path' }, ctx.source_name) then
                                    local dev_icon, _ = require('nvim-web-devicons').get_icon(ctx.label)
                                    if dev_icon then
                                        icon = dev_icon
                                    end
                                else
                                    icon = require('lspkind').symbolic(ctx.kind, {
                                        mode = 'symbol',
                                    })
                                end

                                return icon .. ctx.icon_gap
                            end,
                            highlight = function(ctx)
                                local hl = ctx.kind_hl
                                if vim.tbl_contains({ 'Path' }, ctx.source_name) then
                                    local dev_icon, dev_hl = require('nvim-web-devicons').get_icon(ctx.label)
                                    if dev_icon then
                                        hl = dev_hl
                                    end
                                end
                                return hl
                            end
                        }
                    }
                }
            }
        },

        -- Default list of enabled providers defined so that you can extend it
        -- elsewhere in your config, without redefining it, due to `opts_extend`
        sources = {
            -- default = { 'lsp', 'path', 'snippets', 'buffer' },
            default = { 'lsp', 'path', 'buffer', },
        },

        fuzzy = { implementation = "prefer_rust_with_warning" }
    },
    opts_extend = { "sources.default" }
}
