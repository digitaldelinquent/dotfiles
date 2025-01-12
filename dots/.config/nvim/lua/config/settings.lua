-- Set theme
vim.cmd.colorscheme('dracula')

-- Show line numbers

vim.opt.number = true

-- Show file stats

vim.opt.ruler = true

-- Blink cursor on error instead of beeping (grr)

vim.opt.visualbell = true

-- Cursor line and column

vim.opt.cursorline = true
vim.opt.cursorcolum = true

-- Encoding

vim.opt.encoding = 'utf-8'

-- clipboard copy/paste

vim.opt.clipboard = {'unnamed', 'unnamedplus'}

-- Whitespace

vim.opt.wrap = true

vim.opt.textwidth = 79

vim.opt.formatoptions ='tcqrn1'

vim.opt.tabstop = 4

vim.opt.shiftwidth = 4

vim.opt.softtabstop = 4

vim.opt.expandtab = true

-- Cursor motion

vim.opt.scrolloff = 3

vim.opt.backspace = {'indent', 'eol', 'start'}

-- Rendering

vim.opt.ttyfast = true

-- Searching

vim.opt.ignorecase = true

vim.opt.smartcase = true

vim.opt.showmatch = true

