return {
    'MeanderingProgrammer/render-markdown.nvim',
    enabled = true,
    lazy = true,
    ft = { 'markdown', 'codecompanion' },
    dependencies = {
        'nvim-mini/mini.icons',
    },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
        file_types = {
            'markdown', 'codecompanion',
        },
        html = {
            tag = {
                buf     = { icon = " ", highlight = "CodeCompanionChatIcon" },
                file    = { icon = " ", highlight = "CodeCompanionChatIcon" },
                group   = { icon = " ", highlight = "CodeCompanionChatIcon" },
                help    = { icon = "󰘥 ", highlight = "CodeCompanionChatIcon" },
                image   = { icon = " ", highlight = "CodeCompanionChatIcon" },
                symbols = { icon = "󱔁 ", highlight = "CodeCompanionChatIcon" },
                tool    = { icon = " ", highlight = "CodeCompanionChatIcon" },
                url     = { icon = "󰖟 ", highlight = "CodeCompanionChatIcon" },
                user    = { icon = " ", highlight = "CodeCompanionChatIcon" },
                var     = { icon = "󰫧 ", highlight = "CodeCompanionChatIcon" },
            },
        }
    },
}
