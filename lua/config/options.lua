-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Basic options
local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Tabs and indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- Line wrapping
opt.wrap = true                   -- Enable line wrapping
opt.linebreak = true              -- Break lines at word boundaries
opt.showbreak = "↪ "              -- Show line continuation character
opt.breakindent = true            -- Preserve indentation on wrapped lines
opt.breakindentopt = "shift:2"    -- Add extra indentation to wrapped lines

-- Search settings
opt.ignorecase = true
opt.smartcase = true

-- Appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- Backspace
opt.backspace = "indent,eol,start"

-- Clipboard
opt.clipboard:append("unnamedplus")

-- Split windows
opt.splitright = true
opt.splitbelow = true

-- Turn off swapfile
opt.swapfile = false
