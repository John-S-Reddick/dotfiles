require "nvchad.options"

-- add yours here!
-- local o = vim.:o
-- o.cursorlineopt ='both' -- to enable cursorline!
-- 
-- TABSTOP
local o = vim.opt
o.relativenumber = true
o.scrolloff = 6
o.tabstop = 4       -- A TAB character looks like 4 spaces
o.expandtab = true  -- Pressing the TAB key will insert spaces instead of a TAB character
o.softtabstop = 4   -- Number of spaces inserted instead of a TAB character
o.shiftwidth = 4    -- Number of spaces inserted when indentinrequire "nvchad.options"

-- Disable Mouse Support
vim.cmd "map <LeftMouse> <nop>"
vim.cmd "map! <LeftMouse> <nop>"
vim.cmd "map <RightMouse> <nop>"
vim.cmd "map! <RightMouse> <nop>"
vim.cmd "map <2-LeftMouse> <nop>"
vim.cmd "map! <2-LeftMouse> <nop>"
vim.cmd "map <3-LeftMouse> <nop>"
vim.cmd "map! <3-LeftMouse> <nop>"

-- Diable Arrow Keys
vim.cmd "map <Left> <nop>"
vim.cmd "map! <Left> <nop>"
vim.cmd "map <Right> <nop>"
vim.cmd "map! <Right> <nop>"
vim.cmd "map <Up> <nop>"
vim.cmd "map! <Up> <nop>"
vim.cmd "map <Down> <nop>"
vim.cmd "map! <Down> <nop>"

-- autocmds
vim.cmd "autocmd InsertEnter * set nohlsearch"
vim.cmd "autocmd BufEnter * set formatoptions=jcql"
vim.cmd "autocmd FileType python setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab"
vim.cmd "autocmd FileType php setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab"
vim.cmd "autocmd VimLeave * mksession! ~/.Session.vim"
vim.cmd "autocmd BufRead,BufNewFile  * if (line('$') == 1 && getline(1) != '') | set nonumber norelativenumber | else | set number relativenumber | endif"

