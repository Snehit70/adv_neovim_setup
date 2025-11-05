-- Test suite for init.lua
local eq = assert.are.same

describe("Neovim Configuration Init", function()
  it("should load without errors", function()
    local ok = pcall(function()
      dofile(vim.fn.stdpath("config") .. "/init.lua")
    end)
    assert.is_true(ok)
  end)

  it("should set leader key to space", function()
    eq(" ", vim.g.mapleader)
    eq(" ", vim.g.maplocalleader)
  end)
end)
