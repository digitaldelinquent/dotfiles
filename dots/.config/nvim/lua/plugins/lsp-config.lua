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
                'ast_grep',
                'sqlls',
                'terraformls',
                'svelte',
                'nil_ls',
                'jsonls',
            }
        })

        local lspconfig = require('lspconfig')
        local capabilities = require('blink.cmp').get_lsp_capabilities()

        lspconfig.ansiblels.setup({ capabilities = capabilties })
        lspconfig.bashls.setup({ capabilities = capabilties })
        lspconfig.ast_grep.setup({ capabilities = capabilties })
        lspconfig.sqlls.setup({ capabilities = capabilties })
        lspconfig.terraformls.setup({ capabilities = capabilties })
        lspconfig.nil_ls.setup({ capabilities = capabilties })
        lspconfig.jsonls.setup({ capabilities = capabilties })

        vim.keymaps.set('n', 'gd', vim.lsp.buf.definition, {})
        vim.keymaps.set('n', 'K', vim.lsp.buf.hover, {})
        vim.keymaps.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, {})
    end
}
