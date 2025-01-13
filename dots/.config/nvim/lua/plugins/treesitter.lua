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
                'nix',
                'csv',
                'markdown',
                'json',
                'yaml',
                'javascript', 
                'svelte',
                'lua', 
                'vim', 
                'vimdoc', 
                'html'
            },
            sync_install = false,
            highlight = { enable = true },
            indent = { enable = true },  
        })
    end
}
