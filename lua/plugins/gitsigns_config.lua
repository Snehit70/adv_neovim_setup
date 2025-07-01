return {
  "lewis6991/gitsigns.nvim",
  event = "BufReadPre",
  config = function()
    local gitsigns = require("gitsigns")
    gitsigns.setup({
      signs = {
        add          = { text = "│" },
        change       = { text = "┃" },
        delete       = { text = "" },
        topdelete    = { text = "󰐊" },
        changedelete = { text = "~" },
        untracked    = { text = "┆" },
      },
      signcolumn = true,
      numhl      = false,
      linehl     = false,
      word_diff  = false,
      watch_gitdir = { follow_files = true },
      attach_to_untracked = false,
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "right_align",
        delay = 500,
        ignore_whitespace = false,
        virt_text_priority = 100,
        use_focus = true,
      },
      current_line_blame_formatter = "<author>, <author_time:%R> – <summary>",
      sign_priority = 6,
      update_debounce = 100,
      preview_config = {
        style = "minimal",
        border = "rounded",
        relative = "cursor",
        row = 0,
        col = 1,
      },
      yadm = { enable = false },
      on_attach = function(bufnr)
        local gs = require("gitsigns")

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "]c", function()
          if vim.wo.diff then return "]c" end
          vim.schedule(gs.next_hunk)
          return "<Ignore>"
        end, {expr = true})
        map("n", "[c", function()
          if vim.wo.diff then return "[c" end
          vim.schedule(gs.prev_hunk)
          return "<Ignore>"
        end, {expr = true})

        -- Actions under <leader>g
        map("n", "<leader>gs", gs.stage_hunk, {desc = "Stage Hunk"})
        map("n", "<leader>gr", gs.reset_hunk, {desc = "Reset Hunk"})
        map("v", "<leader>gs", function() gs.stage_hunk {vim.fn.line("."), vim.fn.line("v")} end, {desc="Stage Hunk (v)"})
        map("v", "<leader>gr", function() gs.reset_hunk {vim.fn.line("."), vim.fn.line("v")} end, {desc="Reset Hunk (v)"})
        map("n", "<leader>gp", gs.preview_hunk, {desc = "Preview Hunk"})
        map("n", "<leader>gb", gs.blame_line, {desc = "Blame Line"})
        map("n", "<leader>gt", gs.toggle_current_line_blame, {desc = "Toggle Line Blame"})

        -- Other handy mappings
        map("n", "<leader>gS", gs.stage_buffer, {desc = "Stage Buffer"})
        map("n", "<leader>gR", gs.reset_buffer, {desc = "Reset Buffer"})
        map("n", "<leader>gd", gs.diffthis, {desc = "Diff This"})
        map("n", "<leader>gD", function() gs.diffthis("~") end, {desc = "Diff This ~"})
        map({"o","x"}, "ih", ":<C-U>Gitsigns select_hunk<CR>", {desc = "Select Hunk"})
      end,
    })
  end,
}
