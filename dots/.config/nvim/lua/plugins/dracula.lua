return {
    -- add dracula
    { "Mofiqul/dracula.nvim" },
    config = function()
        -- Set theme
        vim.cmd.colorscheme('dracula')
    end
}
