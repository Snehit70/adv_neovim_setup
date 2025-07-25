-- my new neovim config for best setup .

require("config.options")

require("config.lazy")


local project_config = vim.fn.getcwd() .. "/.nvim.lua"
if vim.fn.filereadable(project_config) == 1 then
	dofile(project_config)
end
