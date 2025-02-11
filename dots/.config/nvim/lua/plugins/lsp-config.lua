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
                    "bashls",
                    "clangd",
                    "gopls",
                    "pyright",
                    "sqlls",
                    "terraformls",
                    "svelte",
                    "eslint", 
                    "vimls", 
                    "html"
                }
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            local capabilities = require("blink.cmp").get_lsp_capabilities()

            lspconfig.bashls.setup({ capabilities = capabilties })
            lspconfig.clangd.setup({ capabilities = capabilities })
            lspconfig.gopls.setup({ capabilities = capabilities })
            lspconfig.pyright.setup({ capabilities = capabilities })
            lspconfig.sqlls.setup({ capabilities = capabilties })
            lspconfig.terraformls.setup({ capabilities = capabilties })
            lspconfig.svelte.setup({ capabilities = capabilities })
            lspconfig.eslint.setup({ capabilities = capabilities })
            lspconfig.vimls.setup({ capabilities = capabilities })
            lspconfig.html.setup({ capabilities = capabilities })
        end
    }
}
