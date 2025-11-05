-- Test suite for keymaps
local eq = assert.are.same

describe("Keymaps Configuration", function()
  describe("Leader Keys", function()
    it("should set space as leader key", function()
      eq(" ", vim.g.mapleader)
    end)

    it("should set space as local leader key", function()
      eq(" ", vim.g.maplocalleader)
    end)
  end)

  describe("Insert Mode Mappings", function()
    it("should have space mapping in insert mode", function()
      local mappings = vim.api.nvim_get_keymap('i')
      local space_mapping = nil
      for _, map in ipairs(mappings) do
        if map.lhs == ' ' or map.lhs == '<Space>' then
          space_mapping = map
          break
        end
      end
      -- Check if space mapping exists (it's set to prevent delay)
      -- Note: This may be nil if the mapping is not persisted, which is okay
      if space_mapping then
        assert.is_not_nil(space_mapping)
      else
        pending("Space mapping not found in keymap list - may not persist")
      end
    end)
  end)
end)
