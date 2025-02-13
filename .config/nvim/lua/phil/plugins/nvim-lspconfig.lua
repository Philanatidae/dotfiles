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

        -- mason-lspconfig starts most LSPs automatically, with these exceptions:
        --  - flutter-tools: dartls
    end
}

