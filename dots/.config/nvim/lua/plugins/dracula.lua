return {
    -- add dracula
    { "Mofiqul/dracula.nvim" },
    config = function()
        local dracula = require("dracula")
        dracula.setup()
    
        -- Set theme
        vim.cmd.colorscheme('dracula')
    end
}
