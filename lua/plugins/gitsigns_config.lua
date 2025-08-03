return {
  "lewis6991/gitsigns.nvim",
  -- Lazy-loads the plugin just before a buffer is read (when opening a file).
  -- This optimizes Neovim's startup time as Git signs are only relevant when viewing a file.
  event = "BufReadPre",
  -- Configuration function for the gitsigns.nvim plugin.
  config = function()
    local gitsigns = require("gitsigns")
    gitsigns.setup({
      -- Customizes the characters displayed in the sign column for different Git changes.
      signs = {
        add          = { text = "│" }, -- Thin vertical line for added lines.
        change       = { text = "┃" }, -- Thicker vertical line for changed lines.
        delete       = { text = "" }, -- Icon for deleted lines.
        topdelete    = { text = "" }, -- Icon for deletions at the top of a hunk (changed from default).
        changedelete = { text = "─" }, -- Horizontal line for lines that are both changed and deleted (changed from default).
        untracked    = { text = "┆" }, -- Dotted vertical line for untracked lines.
      },
      -- Ensures the sign column is always visible to display Git indicators.
      signcolumn = true,
      -- Disables highlighting of line numbers for changed lines, reducing visual clutter.
      numhl      = false,
      -- Disables highlighting of the entire line for changed lines, further reducing visual distraction.
      linehl     = false,
      -- Disables word-level diff highlighting, opting for a simpler line-level change indication.
      word_diff  = false,
      -- Tells GitSigns to watch the .git directory for changes and to follow files (update signs when moved/renamed).
      watch_gitdir = { follow_files = true },
      -- Attaches signs to untracked files. This provides immediate visual feedback for new files.
      attach_to_untracked = true,
      -- Disables the 'current line blame' feature by default (shows author/time/summary as virtual text).
      -- It can be toggled on demand with a keymap.
      current_line_blame = false,
      -- Options for how the blame virtual text appears when current_line_blame is enabled.
      current_line_blame_opts = {
        virt_text = true, -- Displays the blame information as virtual text.
        virt_text_pos = "right_align", -- Aligns the virtual text to the right side of the window.
        delay = 750, -- Delay (in ms) before blame text appears, preventing flicker during quick navigation (changed from 500).
        ignore_whitespace = false, -- Does not ignore whitespace changes when determining blame.
        virt_text_priority = 100, -- Sets the display priority for the virtual text.
        use_focus = true, -- Only shows blame when the Neovim window is focused.
      },
      -- Defines the format of the blame virtual text, including author, relative time, commit hash, and summary.
      current_line_blame_formatter = "<author>, <author_time:%R> – <hash:7> <summary>",
      -- Sets the display priority for GitSigns in the sign column, ensuring prominence.
      sign_priority = 6,
      -- Introduces a delay (in ms) before GitSigns updates after a change, making visual updates smoother.
      update_debounce = 200, -- Changed from 100ms for smoother visuals.
      -- Disables GitSigns for files exceeding this length (in lines) to improve performance in very large files.
      
      -- Formatter function to provide a string for the statusline (e.g., for lualine.nvim).
      -- Shows number of added, changed, and removed lines.
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
      
      -- Function executed every time GitSigns attaches to a new buffer, used for buffer-local keymaps.
      on_attach = function(bufnr)
        local gs = require("gitsigns")

        -- Helper function to create buffer-local keymaps.
        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation keymaps (hunk navigation keymaps were removed as per user request).
        

        -- Actions under <leader>g (Git actions).
        -- Hunk-related keymaps (stage/reset hunk, preview hunk, select hunk) were removed as per user request.
        
        
        
        -- Keymap to show Git blame for the current line as virtual text.
        map("n", "<leader>gbl", gs.blame_line, {desc = "Blame Line"})
        -- Keymap to toggle the current line blame feature on/off for the current buffer.
        map("n", "<leader>gt", gs.toggle_current_line_blame, {desc = "Toggle Line Blame"})

        -- Other handy mappings.
        -- Keymap to stage all changes in the current buffer.
        map("n", "<leader>gS", gs.stage_buffer, {desc = "Stage Buffer"})
        -- Keymap to reset all changes in the current buffer.
        map("n", "<leader>gR", gs.reset_buffer, {desc = "Reset Buffer"})
        -- Keymap to open a diff view of the current file against the index.
        map("n", "<leader>gd", gs.diffthis, {desc = "Diff This"})
        -- Keymap to open a diff view of the current file against the last commit.
        map("n", "<leader>gdt", function() gs.diffthis("~") end, {desc = "Diff This ~"})
        -- Keymap to show a quick diff of the current file against the Git index in a floating window.
        map("n", "<leader>gD", function() gs.diffthis("") end, {desc = "Diff This (Floating)"})
        
      end,
    })
  end,
}