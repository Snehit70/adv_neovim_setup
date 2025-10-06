vim.g.mapleader = " " -- Set leader key to space
vim.g.maplocalleader = " " -- Set local leader key to space
vim.keymap.set('i', '<Space>', '<Space>', { noremap = true, silent = true }) -- Prevent space delay in insert mode
local opt = vim.opt
opt.number = true -- Show line numbers
opt.relativenumber = true -- Show relative line numbers
opt.tabstop = 2 -- Number of spaces for tab character
opt.shiftwidth = 2 -- Number of spaces for indentation
opt.expandtab = true -- Use spaces instead of tabs
opt.linebreak = true -- Break lines at word boundaries
opt.showbreak = "↪ " -- Visual indicator for wrapped lines
opt.breakindent = true -- Preserve indentation on wrapped lines
opt.breakindentopt = "shift:2" -- Additional indent for wrapped lines
opt.ignorecase = true -- Case insensitive search
opt.smartcase = true -- Case sensitive when uppercase present
opt.termguicolors = true -- Enable 24-bit RGB colors
opt.background = "dark" -- Set dark background
opt.signcolumn = "yes" -- Always show sign column
opt.cursorline = true -- Highlight current line
opt.updatetime = 300 -- Faster completion (4000ms default)
opt.timeoutlen = 300 -- Time to wait for key sequence
opt.conceallevel = 3 -- Hide markup characters
opt.concealcursor = "n" -- Hide concealed text in normal mode
opt.pumheight = 10 -- Maximum popup menu height
opt.showmode = false -- Don't show mode in command line
opt.shortmess:append("c") -- Don't show completion messages
opt.whichwrap:append("<>[]hl") -- Allow cursor wrap with arrow keys
opt.scrolloff = 8 -- Keep 8 lines visible when scrolling
opt.mouse = "" -- Disable mouse support
opt.clipboard:append("unnamedplus") -- Use system clipboard
opt.splitright = false -- Split windows to the left
opt.splitbelow = false -- Split windows above
opt.swapfile = false -- Disable swap files
opt.undofile = true -- Enable persistent undo
opt.undodir = vim.fn.stdpath("data") .. "/undodir" -- Set undo directory
