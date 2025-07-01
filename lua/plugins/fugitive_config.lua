return {
  "tpope/vim-fugitive",
  cmd = { "Git", "G" },
  keys = {
    { "<leader>gG", "<cmd>Git<CR>", desc = "Fugitive: Git status" },
    { "<leader>gc", "<cmd>Git commit<CR>", desc = "Fugitive: Git commit" },
    { "<leader>gL", "<cmd>Git log --oneline<CR>", desc = "Fugitive: Git log (oneline)" },
    { "<leader>gl", "<cmd>Git log<CR>", desc = "Fugitive: Git log (full)" },
    { "<leader>gh", "<cmd>Git log %<CR>", desc = "Fugitive: File history" },
    { "<leader>gD", "<cmd>Gdiffsplit<CR>", desc = "Fugitive: Diff with HEAD" },
    { "<leader>gm", "<cmd>Git mergetool<CR>", desc = "Fugitive: Mergetool" },
    { "<leader>gp", "<cmd>Git push<CR>", desc = "Fugitive: Git push" },
    { "<leader>gP", "<cmd>Git pull<CR>", desc = "Fugitive: Git pull" },
    { "<leader>gb", "<cmd>Git branch<CR>", desc = "Fugitive: Git branches" },
    { "<leader>gst", "<cmd>Git stash<CR>", desc = "Fugitive: Git stash" },
    { "<leader>gsr", "<cmd>Git stash pop<CR>", desc = "Fugitive: Git stash pop" },
  },
  config = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "fugitive",
      callback = function()
        -- Optional: map q to quit the fugitive window
        vim.keymap.set("n", "q", "<cmd>q<CR>", { buffer = true, desc = "Close Fugitive" })
      end,
    })
  end,
}
