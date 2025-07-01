return {
  "windwp/nvim-ts-autotag",
  event = "InsertEnter",
  ft = {
    "html", "xml", "javascript", "javascriptreact",
    "typescript", "typescriptreact", "markdown",
    "htmldjango", "jinja", "templ", "ejs",
  },
  config = function()
    local ok, autotag = pcall(require, "nvim-ts-autotag")
    if not ok then return end

    autotag.setup({
      opts = {
        enable_close_on_slash = true,     -- Enables self-closing tags like <img />
        enable_rename = false,            -- Avoid tag rename conflicts with other plugins
        enable_close_on_rename = false,   -- Disables auto-rename behavior (prevents conflict)
      },
    })
  end,
}
