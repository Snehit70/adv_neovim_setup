-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Basic options
local opt = vim.opt

-- Command line height
opt.cmdheight = 1

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Tabs and indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- Line wrapping
opt.wrap = true
opt.linebreak = true
opt.showbreak = "↪ "
opt.breakindent = true
opt.breakindentopt = "shift:2"

-- Search settings
opt.ignorecase = true
opt.smartcase = true

-- Appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- Scrolling
opt.scrolloff = 8

-- Mouse
opt.mouse = "a"

-- Backspace
opt.backspace = "indent,eol,start"

-- Clipboard
opt.clipboard:append("unnamedplus")

-- Split windows
opt.splitright = true
opt.splitbelow = true

-- Turn off swapfile
opt.swapfile = false

-- Enable undofile
opt.undofile = true
opt.undodir = vim.fn.stdpath("data") .. "/undodir"
