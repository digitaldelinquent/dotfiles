return {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    config = function()
        require("mason").setup()
        
        require("mason-lspconfig").setup({
            ensure_installed = {
                'ansiblels',
                'bashls',
                'sqlls',
                'terraformls',
                'svelte',
                'nil_ls',
                'clangd',
                'zls',
                'gopls',
                'pyright',
                'eslint', 
                'lua_ls', 
                'vimls', 
                'html'
            }
        })

        local lspconfig = require('lspconfig')
        local capabilities = require('blink.cmp').get_lsp_capabilities()

        lspconfig.ansiblels.setup({ capabilities = capabilties })
        lspconfig.bashls.setup({ capabilities = capabilties })
        lspconfig.sqlls.setup({ capabilities = capabilties })
        lspconfig.terraformls.setup({ capabilities = capabilties })
        lspconfig.svelte.setup({ capabilities = capabilities })
        lspconfig.nil_ls.setup({ capabilities = capabilties })
        lspconfig.clangd.setup({ capabilities = capabilities })
        lspconfig.zls.setup({ capabilities = capabilities })
        lspconfig.gopls.setup({ capabilities = capabilities })
        lspconfig.pyright.setup({ capabilities = capabilities })
        lspconfig.eslint.setup({ capabilities = capabilities })
        lspconfig.lua_ls.setup({ capabilities = capabilities })
        lspconfig.vimls.setup({ capabilities = capabilities })
        lspconfig.html.setup({ capabilities = capabilities })

        vim.keymaps.set('n', 'gd', vim.lsp.buf.definition, {})
        vim.keymaps.set('n', 'K', vim.lsp.buf.hover, {})
        vim.keymaps.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, {})
    end
}
