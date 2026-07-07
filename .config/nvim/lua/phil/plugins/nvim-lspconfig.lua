return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'saghen/blink.cmp',
    },
    enabled = true,
    lazy = true,
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
        local capabilities = {
            textDocument = {
                foldingRange = {
                    dynamicRegistration = false,
                    lineFoldingOnly = false,
                }
            }
        }

        capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)

        vim.lsp.config('*', {
            capabilities = capabilities,
        })
        vim.lsp.config('clangd', {
            cmd = { 'clangd',
                '--all-scopes-completion',
                --'--header-insertion=never',
                '--completion-style=detailed' },
            filetypes = { 'c', 'cpp', 'objc', 'objcpp', },
            -- single_file_support = false,
        })
        -- mason-lspconfig starts most LSPs automatically, with these exceptions:
        --  - flutter-tools: dartls

        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('user.lsp', { clear = true }),
            callback = function(e)
                local client = vim.lsp.get_client_by_id(e.data.client_id)

                vim.keymap.set('n', 'grd', vim.lsp.buf.definition, {
                    desc = 'Go to definition',
                    buffer = e.buf,
                })

                if client and client.name == 'clangd' then
                    vim.keymap.set('n', '<leader>o', ':LspClangdSwitchSourceHeader<CR>', {
                        desc = 'Switch header/source file',
                        buffer = e.buf
                    })
                end

                if client and client:supports_method('textDocument/inlayHint') then
                    vim.lsp.inlay_hint.enable(true)
                end
            end
        })

        require('which-key').add({
            { 'gr',  group = 'LSP' },
            { 'grn', desc = 'Rename symbol' },
            { 'gra', desc = 'Code action',    mode = { 'n', 'x' } },
            { 'grr', desc = 'References' },
            { 'gri', desc = 'Implementation' },
            { 'grt', desc = 'Type definition' },
            { 'grx', desc = 'codelens' },
        })
    end
}
