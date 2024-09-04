--- Neovim config file
--  Published on Github: ValentinMENDIss

local opt = vim.opt


--- visuals

vim.cmd("let g:netrw_liststyle = 3")  -- change tree list style
opt.number = true -- show line numbers
opt.wrap = false -- do not wrap lines
opt.cursorline = true -- highlight the line where the cursor is


-- themes
opt.termguicolors = false -- enable termguicolors for themes support
opt.background = "dark" -- set colorschemes to dark/light
opt.signcolumn = "yes" -- show sign column


--- tabs & indentation
opt.expandtab = true -- expand tab to spaces
opt.tabstop = 4 -- 4 spaces for tabs (TAB) 
opt.softtabstop = 4 -- delete Spaces by 4 (Characters)
opt.expandtab = true -- insert Spaces instead of Tabs (avoiding alignment irregularities)
opt.autoindent = true -- indent next line to the same level (Useful for aligning code)


-- search settings
opt.smartcase = true -- turn the mode case-sensitive on for searching


-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom
