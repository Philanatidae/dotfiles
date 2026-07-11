return {
    'saghen/blink.cmp',
    version = '1.*',
    enabled = true,
    lazy = false, -- Plugin will lazy load itself
    --
    -- use a release tag to download pre-built binaries
    dependencies = {
        'nvim-mini/mini.icons',
        'onsails/lspkind.nvim',
        'L3MON4D3/LuaSnip',
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
            window = {
                direction_priority = { 's', 'n' },
            },
        },

        completion = {
            accept = {
                auto_brackets = {
                    enabled = false,
                },
            },
            documentation = {
                auto_show = true
            },
            ghost_text = {
                enabled = true,
                show_with_selection = true,
                show_without_selection = true,
                show_with_menu = true,
                show_without_menu = true,
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
                        { 'label',     'label_description', gap = 1, },
                        { 'kind_icon', 'kind',              gap = 1 },
                    },
                    components = {
                        kind_icon = {
                            text = function(ctx)
                                local icon = ctx.kind_icon
                                if vim.tbl_contains({ 'Path' }, ctx.source_name) then
                                    local dev_icon = require('mini.icons').get('file', ctx.label)
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
                                    local miniicons = require('mini.icons')
                                    local icon, category = miniicons.get('file', ctx.label)
                                    if icon then
                                        hl = miniicons.get_hl_name(category, ctx.label)
                                    end
                                end
                                return hl
                            end
                        }
                    }
                }
            }
        },

        sources = {
            default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer', },
            providers = {
                lazydev = {
                    name = 'LazyDev',
                    module = 'lazydev.integrations.blink',
                    -- make lazydev completions top priority (see `:h blink.cmp`)
                    score_offset = 100,
                },
            },
        },

        snippets = { preset = 'luasnip' },

        fuzzy = { implementation = 'prefer_rust_with_warning' }
    },
    opts_extend = { 'sources.default' }
}
