return {
    "nvim-treesitter/nvim-treesitter", 
    build = ":TSUpdate",
    config = function()
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            ensure_installed = { 
                'c', 
                'go',
                'bash',
                'python',
                'sql',
                'terraform',
                'elixir',
                'helm',
                'nix',
                'csv',
                'markdown',
                'json',
                'yaml',
                'javascript', 
                'lua', 
                'vim', 
                'vimdoc', 
                'html'
            },
            sync_install = false,
            highlight = { enable = true },
            indent = { enable = true }
        })
    end
}
