return {
  "lewis6991/gitsigns.nvim",
  event = {"BufReadPre", "BufNewFile"},
  config = function()
    local gitsigns = require("gitsigns")
    gitsigns.setup({
      signs = {
        add          = { text = "│" }, -- Thin vertical line for added lines.
        change       = { text = "┃" }, -- Thicker vertical line for changed lines.
        delete       = { text = "" }, -- Icon for deleted lines.
        topdelete    = { text = "" }, -- Icon for deletions at the top of a hunk (changed from default).
        changedelete = { text = "─" }, -- Horizontal line for lines that are both changed and deleted (changed from default).
        untracked    = { text = "┆" }, -- Dotted vertical line for untracked lines.
      },
      signcolumn = true,
      numhl      = true, -- Highlights line numbers for changed lines.
      linehl     = false,
      word_diff  = false,
      watch_gitdir = { follow_files = true },
      max_file_length = 10000, -- Disables gitsigns for files longer than 10000 lines for performance.
      attach_to_untracked = true,
      current_line_blame = false,
      current_line_blame_opts = {
        virt_text = true, -- Displays the blame information as virtual text.
        virt_text_pos = "right_align", -- Aligns the virtual text to the right side of the window.
        delay = 750, -- Delay (in ms) before blame text appears, preventing flicker during quick navigation (changed from 500).
        ignore_whitespace = false, -- Does not ignore whitespace changes when determining blame.
        virt_text_priority = 100, -- Sets the display priority for the virtual text.
        use_focus = true, -- Only shows blame when the Neovim window is focused.
      },
      current_line_blame_formatter = " <author> • <author_time:%R> • <summary>",
      current_line_blame_formatter_nc = " <author> • Uncommitted changes",
      sign_priority = 6,
      update_debounce = 100, -- Optimized for responsive feedback (changed from 200ms).
      status_formatter = function(opts)
        if not opts.added and not opts.changed and not opts.removed then
          return ''
        end
        local str = ''
        if opts.added then
          str = str .. ' +' .. opts.added
        end
        if opts.changed then
          str = str .. ' ~' .. opts.changed
        end
        if opts.removed then
          str = str .. ' -' .. opts.removed
        end
        return str
      end,
      preview_config = {
        border = "rounded",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1
      },
      
      on_attach = function(bufnr)
        local gs = require("gitsigns")

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Note: Hunk navigation ([c, ]c), stage/reset hunk, preview hunk, and text objects
        -- are intentionally not configured as they are not needed for this setup.

        -- Buffer Operations
        map("n", "<leader>gS", gs.stage_buffer, {desc = "Stage Buffer"})
        map("n", "<leader>gR", gs.reset_buffer, {desc = "Reset Buffer"})
        
        -- Blame Operations
        map("n", "<leader>gbl", gs.blame_line, {desc = "Blame Line"})
        map("n", "<leader>gb", gs.blame, {desc = "Full Blame"})
        map("n", "<leader>gt", gs.toggle_current_line_blame, {desc = "Toggle Line Blame"})
        
        -- Toggle Operations
        map("n", "<leader>gts", gs.toggle_signs, {desc = "Toggle Signs"})
        map("n", "<leader>gtd", gs.toggle_deleted, {desc = "Toggle Deleted"})
        
        -- Diff Operations
        map("n", "<leader>gd", gs.diffthis, {desc = "Diff This"})
        map("n", "<leader>gdt", function() gs.diffthis("~") end, {desc = "Diff This ~"})
        map("n", "<leader>gD", function() gs.diffthis("") end, {desc = "Diff This (Floating)"})
        
        -- Telescope Integration (if available)
        local has_telescope, _ = pcall(require, "telescope.builtin")
        if has_telescope then
          map("n", "<leader>gf", "<cmd>Telescope git_status<cr>", {desc = "Git Status (Telescope)"})
          map("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", {desc = "Git Commits (Telescope)"})
          map("n", "<leader>gbc", "<cmd>Telescope git_bcommits<cr>", {desc = "Buffer Commits (Telescope)"})
        end
      end,
    })
  end,
}
