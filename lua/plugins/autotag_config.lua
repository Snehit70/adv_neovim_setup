return {
  "windwp/nvim-ts-autotag",
  event = "InsertEnter",
  ft = {
    "html","javascript",
    "typescript","markdown",
    "htmldjango", "jinja",
  },
  config = function()
    local ok, autotag = pcall(require, "nvim-ts-autotag")
    if not ok then return end

    autotag.setup({
      opts = {
        enable_close_on_slash = true,
        enable_auto_close = true,
        disable_autotag_for_tags = {"br", "hr", "input", "img", "link", "meta"},
        enable_rename = true,
        excluded_filetypes = {"json", "yaml"},
        enable_close_on_rename = false,
      },
    })
  end,
}
