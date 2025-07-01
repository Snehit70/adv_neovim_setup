return {
  "echasnovski/mini.surround",
  version = false, -- Always use latest
  event = "VeryLazy", -- loads on startup, but after init
  config = function()
    require("mini.surround").setup({
      -- Use classic Vim keymaps
      mappings = {
        add = "ys",            -- Add surrounding
        delete = "ds",         -- Delete surrounding
        replace = "cs",        -- Replace surrounding
        find = "sf",           -- Find surrounding (like `f`)
        find_left = "sF",      -- Find surrounding (backward)
        highlight = "sh",      -- Highlight surrounding
        update_n_lines = "sn", -- Update number of surrounding lines
        suffix_last = "l",     -- For `sfl`, `sFl`, etc.
        suffix_next = "n",     -- For `sfn`, `sFn`, etc.
      },

      -- Use in Visual mode too
      silent = false,
      respect_selection_type = true,
      search_method = "cover_or_next",
    })

    -- Optional: Define custom surround for tags (like `<div> ... </div>`)
    -- Example: ysd for HTML-style block
    vim.api.nvim_set_keymap("n", "ysd", 'vB:<Esc>`>a</div><Esc>`<i<div>', { noremap = true, silent = true })

    -- Optional: add more via MiniSurround.add/remove if needed
  end,
}
