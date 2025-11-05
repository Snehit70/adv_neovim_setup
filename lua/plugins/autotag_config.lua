return {
  "windwp/nvim-ts-autotag",
  ft = {
    "html",
    "javascript",
    "typescript",
    "javascriptreact",  -- .jsx files
    "typescriptreact",  -- .tsx files
    "markdown",
    "htmldjango",
    "jinja",
    "vue",              -- Vue.js single file components
    "xml",              -- XML files
  },
  config = function()
    local autotag = require("nvim-ts-autotag")

    autotag.setup({
      enable_close_on_slash = true,
      enable_auto_close = true,
      disable_autotag_for_tags = {
        "br", "hr", "input", "img", "link", "meta",
        "area", "base", "col", "embed", "param", "source", "track", "wbr"
      },
      enable_rename = true,
      excluded_filetypes = {"json", "yaml"},
      enable_close_on_rename = false,
    })
  end,
}
