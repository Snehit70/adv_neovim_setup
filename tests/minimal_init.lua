-- Minimal init file for running tests
-- This ensures tests can run in a clean environment

-- Set leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Add lazy.nvim to runtimepath if needed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Ensure plenary is available for tests
local plenary_path = vim.fn.stdpath("data") .. "/lazy/plenary.nvim"
if (vim.uv or vim.loop).fs_stat(plenary_path) then
  vim.opt.rtp:prepend(plenary_path)
end

-- Basic options needed for testing
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false
