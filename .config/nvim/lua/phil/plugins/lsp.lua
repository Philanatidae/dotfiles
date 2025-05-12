-- @todo This file doesn't make sense, I think the dependencies are
-- in the wrong order, and it's not letting me use Telescope with
-- flutter-tools.
return {
    "neovim/nvim-lspconfig",
    lazy = false,
    cond = not vim.g.vscode,
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",

        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/nvim-cmp",

        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",

        "j-hui/fidget.nvim",

        "nvim-flutter/flutter-tools.nvim",
    },
    config = function()
        local cmp = require("cmp")
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend("force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities());

        require("fidget").setup()
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "clangd", "lua_ls", "cmake", "html", "pylsp",
            },
            automatic_installation = {
                exclude = { "clangd" } -- Always use local copy
            },
            handlers = {
                function(server_name) -- default handler
                    require("lspconfig")[server_name].setup({
                        capabilities = capabilities
                    })
                end,

                -- LSP-specific handlers
                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup({
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { "vim", }
                                }
                            }
                        }
                    })
                end,
                ["clangd"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.clangd.setup({
                        capabilities = capabilities,
                        cmd = {
                            "clangd",                                                                    -- On macOS, switch to Xcode included clangd
                            "--background-index",
                            "--compile-commands-dir=/Users/philiprader/Developer/Git/FFBrickGame/ebuild" -- This is the way it works for some reason?
                            -- "--compile-commands-dir=./esbuild", -- Test, we need a more permanent config for this
                        }
                    })
                end,
            }
        })

        -- @todo macOS only
        -- local lspconfig = require("lspconfig")
        -- lspconfig["sourcekit"].setup({
        --     capabilities = capabilities,
        -- })

        local cmp_select = { behavior = cmp.SelectBehavior.Select }
        cmp.setup({
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                -- ["<CR>"] = cmp.mapping.confirm({ select = true }),
                ["<CR>"] = cmp.mapping.confirm({ select = false }),
                ["<Tab>"] = cmp.mapping.select_next_item(cmp_select),
                ["<S-Tab>"] = cmp.mapping.select_prev_item(cmp_select),
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" },
            }, {
                { name = "buffer" },
            })
        })

        vim.diagnostic.config({
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            }
        })

        require("flutter-tools").setup({
            dev_log = {
                enabled = true,
                filter = nil,
                notify_errors = false,
                open_cmd = "tabedit", -- @todo Maybe floating window instead?
                focus_on_open = false,
            },
        })
        vim.keymap.set('n', '<leader>Fr', '<cmd>FlutterRun<CR>', { desc = "Flutter Run (hot reload on save)" })
        vim.keymap.set('n', '<leader>FR', '<cmd>FlutterRestart<CR>', { desc = "Flutter Hot Restart" })
        vim.keymap.set('n', '<leader>Fq', '<cmd>FlutterQuit<CR>', { desc = "Flutter Quit" })
        vim.keymap.set('n', '<leader>Fo', '<cmd>FlutterOutlineToggle<CR>', { desc = "Flutter Outline Toggle" })
        -- require("telescope").load_extension("flutter")
        -- vim.keymap.set('n', '<leader>SF', '<cmd>Telescope flutter commands<CR>')
    end
}
