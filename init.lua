--my new neovim config for best setup .

-- Bootstrap lazy.nvim

-- Load core configurations
require("config.options")

require("config.lazy")



require("config.keymaps")

-- Automatically load project-specific .nvim.lua if it exists
local project_config = vim.fn.getcwd() .. "/.nvim.lua"
if vim.fn.filereadable(project_config) == 1 then
	dofile(project_config)
end
