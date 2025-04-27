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
                    "elixirls",
                    "helm_ls",
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

            local map = function(type, key, value)
                vim.api.nvim_buf_set_keymap(0,type,key,value,{noremap = true, silent = true})
            end

            -- Set go to definition key maps
            local custom_attach = function(client)
                map('n','gD','<cmd>lua vim.lsp.buf.declaration()<CR>')
                map('n','gd','<cmd>vsplit | lua vim.lsp.buf.definition()<CR>')
            end

            local lsp_servers = {
                "bashls", "clangd", "gopls", "pyright", "sqlls", 
                "terraformls", "elixirls", "helm_ls", "eslint", "vimls", "html"
            }

            -- Setup LSPs by iterating
            for _, lsp in ipairs(lsp_servers) do
                if lsp == "elixirls" then
                    lspconfig[lsp].setup({
                        capabilities = capabilities,  -- Fixed typo here
                        cmd = { "language_server.sh" },
                        on_attach = custom_attach
                    })
                else
                    lspconfig[lsp].setup({
                        capabilities = capabilities,  -- Fixed typo here
                        on_attach = custom_attach
                    })
                end
            end
        end
    }
}
