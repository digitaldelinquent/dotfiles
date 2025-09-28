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
                    "ruff",
                    "sqlls",
                    "terraformls",
                    "elixirls",
                    "vimls", 
                }
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
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
                "bashls", 
                "clangd", 
                "ruff", 
                "sqlls", 
                "terraformls", 
                "elixirls",
                "vimls",
            }

            -- Setup LSPs by iterating
            for _, lsp in ipairs(lsp_servers) do
                vim.lsp.enable(lsp)
                if lsp == "elixirls" then
                    vim.lsp.config(lsp, {
                        capabilities = capabilities,
                        cmd = { "language_server.sh" },
                        on_attach = custom_attach
                    })
                else
                    vim.lsp.config(lsp, {
                        capabilities = capabilities,
                        on_attach = custom_attach
                    })
                end
            end

            vim.diagnostic.config({
                virtual_text = true,
                underline = true,
                update_in_insert = false,
                severity_sort = true,
                float = {
                    border = "rounded",
                    source = true,
                },
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = "󰅚 ",
                        [vim.diagnostic.severity.WARN] = "󰀪 ",
                        [vim.diagnostic.severity.INFO] = "󰋽 ",
                        [vim.diagnostic.severity.HINT] = "󰌶 ",
                    },
                    numhl = {
                        [vim.diagnostic.severity.ERROR] = "ErrorMsg",
                        [vim.diagnostic.severity.WARN] = "WarningMsg",
                    },
                },
            })
        end
    }
}
