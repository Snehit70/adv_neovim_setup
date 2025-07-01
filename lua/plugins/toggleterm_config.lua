-- ~/.config/nvim/lua/plugins/toggleterm.lua
return {
  "akinsho/toggleterm.nvim",
  version = "*",
  keys = {
    { "<leader>tt", desc = "Toggle floating terminal" },
    { "<leader>th", desc = "Toggle horizontal terminal" },
  },
  config = function()
    local ok, toggleterm = pcall(require, "toggleterm")
    if not ok then return end

    toggleterm.setup({
      -- Shared settings
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      close_on_exit = true,
      hide_numbers = true,
      shade_terminals = true,
      shading_factor = 2,

      -- Default terminal = float
      direction = "float",
      float_opts = {
        border = "curved",
        winblend = 10,
        width = math.floor(vim.o.columns * 0.8),
        height = 10,
      },

      -- Horizontal terminal fallback (used with :ToggleTerm direction=horizontal)
      size = 15,
    })

    -- Terminal-specific keymaps
    function _G.set_terminal_keymaps()
      local opts = { noremap = true }
      vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
      vim.api.nvim_buf_set_keymap(0, "t", "jk", [[<C-\><C-n>]], opts)
      vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-w>h]], opts)
      vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-w>j]], opts)
      vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-w>k]], opts)
      vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-w>l]], opts)
    end

    vim.cmd("autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()")

    -- Leader mappings for float and horizontal terminals
    vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm direction=float<CR>", { desc = "Toggle float terminal" })
    vim.keymap.set("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<CR>", { desc = "Toggle horizontal terminal" })
  end,
}
