-- Test suite for config/options.lua
local eq = assert.are.same

describe("Options Configuration", function()
  before_each(function()
    -- Load options configuration
    package.loaded["config.options"] = nil
    require("config.options")
  end)

  describe("Basic Settings", function()
    it("should enable line numbers", function()
      assert.is_true(vim.opt.number:get())
    end)

    it("should enable relative line numbers", function()
      assert.is_true(vim.opt.relativenumber:get())
    end)

    it("should set tab settings correctly", function()
      eq(2, vim.opt.tabstop:get())
      eq(2, vim.opt.shiftwidth:get())
      assert.is_true(vim.opt.expandtab:get())
    end)

    it("should enable smart indent", function()
      assert.is_true(vim.opt.smartindent:get())
    end)
  end)

  describe("Line Wrapping", function()
    it("should enable line wrapping", function()
      assert.is_true(vim.opt.wrap:get())
    end)

    it("should enable line break at word boundaries", function()
      assert.is_true(vim.opt.linebreak:get())
    end)

    it("should set show break character", function()
      eq("↪ ", vim.opt.showbreak:get())
    end)

    it("should preserve indentation on wrapped lines", function()
      assert.is_true(vim.opt.breakindent:get())
    end)
  end)

  describe("Search Settings", function()
    it("should enable case insensitive search", function()
      assert.is_true(vim.opt.ignorecase:get())
    end)

    it("should enable smart case", function()
      assert.is_true(vim.opt.smartcase:get())
    end)
  end)

  describe("Visual Settings", function()
    it("should enable true colors", function()
      assert.is_true(vim.opt.termguicolors:get())
    end)

    it("should set dark background", function()
      eq("dark", vim.opt.background:get())
    end)

    it("should show sign column", function()
      eq("yes", vim.opt.signcolumn:get())
    end)

    it("should highlight current line", function()
      assert.is_true(vim.opt.cursorline:get())
    end)

    it("should disable show mode", function()
      assert.is_false(vim.opt.showmode:get())
    end)
  end)

  describe("Performance Settings", function()
    it("should set update time to 300ms", function()
      eq(300, vim.opt.updatetime:get())
    end)

    it("should set timeout length to 300ms", function()
      eq(300, vim.opt.timeoutlen:get())
    end)

    it("should set popup menu height to 10", function()
      eq(10, vim.opt.pumheight:get())
    end)
  end)

  describe("Scroll and Mouse Settings", function()
    it("should set scroll offset to 8", function()
      eq(8, vim.opt.scrolloff:get())
    end)

    it("should disable mouse", function()
      local mouse = vim.opt.mouse:get()
      -- vim.opt returns empty table for empty string
      assert.is_true(mouse == "" or (type(mouse) == "table" and next(mouse) == nil))
    end)
  end)

  describe("Window Split Settings", function()
    it("should split right", function()
      assert.is_true(vim.opt.splitright:get())
    end)

    it("should split below", function()
      assert.is_true(vim.opt.splitbelow:get())
    end)
  end)

  describe("File Settings", function()
    it("should disable swap files", function()
      assert.is_false(vim.opt.swapfile:get())
    end)

    it("should enable undo file", function()
      assert.is_true(vim.opt.undofile:get())
    end)

    it("should set undo directory", function()
      local expected = vim.fn.stdpath("data") .. "/undodir"
      local undodir = vim.opt.undodir:get()
      -- vim.opt may return array with single element
      if type(undodir) == "table" then
        eq(expected, undodir[1])
      else
        eq(expected, undodir)
      end
    end)
  end)

  describe("Concealment Settings", function()
    it("should set conceal level to 3", function()
      eq(3, vim.opt.conceallevel:get())
    end)

    it("should set conceal cursor to normal mode", function()
      local cc = vim.opt.concealcursor:get()
      -- vim.opt may return table with flag set to true
      if type(cc) == "table" then
        assert.is_true(cc.n == true)
      else
        eq("n", cc)
      end
    end)
  end)
end)
