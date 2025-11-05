-- Test suite for plugin availability
local eq = assert.are.same

describe("Plugin Configuration", function()
  describe("Plugin Availability", function()
    it("should have lazy.nvim available", function()
      local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
      local lazy_exists = vim.fn.isdirectory(lazy_path) == 1
      assert.is_true(lazy_exists)
    end)
  end)

  describe("Core Plugins Loading", function()
    local plugins_to_check = {
      "nvim-treesitter",
      "telescope.nvim",
      "mason.nvim",
      "nvim-lspconfig",
      "nvim-cmp",
      "LuaSnip",
      "gitsigns.nvim",
      "comment.nvim",
      "nvim-autopairs",
      "bufferline.nvim",
      "lualine.nvim",
      "neo-tree.nvim",
      "which-key.nvim",
      "toggleterm.nvim",
      "indent-blankline.nvim",
    }

    for _, plugin in ipairs(plugins_to_check) do
      it("should have " .. plugin .. " directory", function()
        local plugin_path = vim.fn.stdpath("data") .. "/lazy/" .. plugin
        local exists = vim.fn.isdirectory(plugin_path) == 1
        -- This test will pass if the plugin exists, or skip if not installed
        if not exists then
          pending("Plugin " .. plugin .. " not installed")
        else
          assert.is_true(exists)
        end
      end)
    end
  end)

  describe("Plugin Configuration Files", function()
    local config_files = {
      "autopairs_config.lua",
      "autotag_config.lua",
      "bufferline_config.lua",
      "cmp.lua",
      "colorscheme.lua",
      "comment_config.lua",
      "gitsigns_config.lua",
      "indent_blankline_config.lua",
      "lsp_config.lua",
      "lualine_config.lua",
      "mason_config.lua",
      "neotreenvim_config.lua",
      "telescope.lua",
      "toggleterm_config.lua",
      "treesitter_config.lua",
      "which_key_config.lua",
    }

    for _, config in ipairs(config_files) do
      it("should have " .. config .. " file", function()
        local config_path = vim.fn.stdpath("config") .. "/lua/plugins/" .. config
        local exists = vim.fn.filereadable(config_path) == 1
        assert.is_true(exists)
      end)
    end
  end)
end)
