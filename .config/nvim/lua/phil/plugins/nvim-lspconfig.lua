return {
    'neovim/nvim-lspconfig',
    dependencies = {
      'saghen/blink.cmp',
    },
    enabled = true,
    lazy = false,
    config = function()
        local capabilities = {
          textDocument = {
            foldingRange = {
              dynamicRegistration = false,
              lineFoldingOnly = true
            }
          }
        }

        capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)

        vim.lsp.config("*", {
            capabilities = capabilities,
        })
        vim.lsp.config("clangd", {
            cmd = { 'clangd', '--all-scopes-completion', '--header-insertion=never' },
            filetypes = { 'c', 'cpp', 'h', 'hpp', 'm', 'mm', 'hm', 'hmm' },
            single_file_support = false,
        })

        -- mason-lspconfig starts most LSPs automatically, with these exceptions:
        --  - flutter-tools: dartls
    end
}

