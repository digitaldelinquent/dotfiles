return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    'nil_ls',
                    'bashls',
                    'clangd',
                    'zls',
                    'gopls',
                    'pyright',
                    'sqlls',
                    'terraformls',
                    'svelte',
                    'eslint', 
                    'lua_ls', 
                    'vimls', 
                    'html'
                }
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require('lspconfig')
            local capabilities = require('blink.cmp').get_lsp_capabilities()

            lspconfig.nil_ls.setup({ capabilities = capabilties })
            lspconfig.bashls.setup({ capabilities = capabilties })
            lspconfig.clangd.setup({ capabilities = capabilities })
            lspconfig.zls.setup({ capabilities = capabilities })
            lspconfig.gopls.setup({ capabilities = capabilities })
            lspconfig.pyright.setup({ capabilities = capabilities })
            lspconfig.sqlls.setup({ capabilities = capabilties })
            lspconfig.terraformls.setup({ capabilities = capabilties })
            lspconfig.svelte.setup({ capabilities = capabilities })
            lspconfig.eslint.setup({ capabilities = capabilities })
            lspconfig.lua_ls.setup({ capabilities = capabilities })
            lspconfig.vimls.setup({ capabilities = capabilities })
            lspconfig.html.setup({ capabilities = capabilities })

            vim.keymaps.set('n', 'gd', vim.lsp.buf.definition, {})
            vim.keymaps.set('n', 'K', vim.lsp.buf.hover, {})
            vim.keymaps.set({ 'n', 'v' }, '<ctrl>mm', vim.lsp.buf.code_action, {})
        end
    }
}
