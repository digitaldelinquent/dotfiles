return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        options = {
            icons_enabled = true,
            theme = 'dracula'
        }
    end
}
