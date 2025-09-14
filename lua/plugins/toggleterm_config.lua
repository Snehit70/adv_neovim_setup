return {
  "akinsho/toggleterm.nvim",
  version = "*",
  keys = {
    { "<leader>tt", desc = "Toggle floating terminal" },
  },
  config = function()
    local ok, toggleterm = pcall(require, "toggleterm")
    if not ok then 
      vim.notify("toggleterm not found!", vim.log.levels.ERROR)
      return 
    end

    toggleterm.setup({
      -- Basic settings
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      close_on_exit = true,
      hide_numbers = true,
      
      -- Focus on floating terminal only
      direction = "float",
      float_opts = {
        border = "rounded",
        winblend = 0,
        -- Proper size calculations (fixed the bug!)
        width = math.floor(vim.o.columns * 0.8),
        height = math.floor(vim.o.lines * 0.8),
        -- Center the terminal
        row = math.floor(vim.o.lines * 0.1),
        col = math.floor(vim.o.columns * 0.1),
      },
      
      -- Terminal styling
      shade_terminals = false, -- Cleaner look
      shading_factor = 1,
    })

    -- Modern terminal keymaps using vim.keymap.set
    vim.api.nvim_create_autocmd("TermOpen", {
      pattern = "term://*toggleterm#*",
      callback = function()
        local opts = { buffer = 0, silent = true }
        
        -- Exit terminal mode
        vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
        vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
        
        -- Window navigation from terminal
        vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-w>h]], opts)
        vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-w>j]], opts)
        vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-w>k]], opts)
        vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-w>l]], opts)
        
        -- Quick close
        vim.keymap.set("t", "<C-q>", "<cmd>close<CR>", opts)
      end,
    })

    -- Simple keymap for your use case
    vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm<CR>", { 
      desc = "Toggle floating terminal",
      silent = true 
    })
  end,
}
