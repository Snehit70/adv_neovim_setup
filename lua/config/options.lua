-- This file sets up fundamental Neovim options that control its behavior and appearance.
-- Each option is explained below, along with its current setting and how you might change it.

-- ==============================
-- Global Settings
-- ==============================

-- Set leader key: This is a special key used as a prefix for many custom keybindings.
-- Currently: Set to <Space>.
-- To change: You can set it to any key, e.g., `vim.g.mapleader = ","` for comma.
vim.g.mapleader = " "
vim.g.maplocalleader = " " -- Local leader key, often same as global leader.

-- 'opt' is a shorthand for `vim.opt`, used to set Neovim options.
local opt = vim.opt

-- ==============================
-- Basic Editor Behavior
-- ==============================

-- Command line height: Controls the height of the command line at the bottom.
-- Currently: 1 line.
-- To change: Increase for more space for messages/commands (e.g., `opt.cmdheight = 2`).
opt.cmdheight = 1

-- Line numbers:
-- `number`: Shows absolute line numbers.
-- `relativenumber`: Shows line numbers relative to the cursor (e.g., 1, 2, 3 above/below cursor).
-- Currently: Both are true, providing excellent navigation for motions.
-- To change: Set to `false` for either to disable.
opt.number = true
opt.relativenumber = true

-- Tabs and indentation:
-- `tabstop`: Number of spaces a <Tab> character counts for.
-- `shiftwidth`: Number of spaces used for (auto)indentation.
-- `expandtab`: Converts <Tab> characters to spaces.
-- `autoindent`: Automatically indents new lines.
-- Currently: All set to 2 spaces for tabs/indentation, and tabs are converted to spaces.
-- To change: Adjust `tabstop` and `shiftwidth` (e.g., `4` for Python). Set `expandtab = false` to use actual tabs.
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- Line wrapping:
-- `wrap`: Enables soft line wrapping (lines break visually, not actually in the file).
-- `linebreak`: Breaks lines at word boundaries, not in the middle of words.
-- `showbreak`: String displayed at the start of a wrapped line.
-- `breakindent`: Wrapped lines are indented to the same level as the original line.
-- `breakindentopt`: Options for `breakindent` (e.g., `shift:2` shifts wrapped lines by 2 spaces).
-- Currently: Lines wrap visually, breaking at words, with a '↪' indicator and proper indentation.
-- To change: Set `wrap = false` to disable wrapping. Adjust `showbreak` or `breakindentopt` for visual preference.
opt.wrap = true
opt.linebreak = true
opt.showbreak = "↪ "
opt.breakindent = true
opt.breakindentopt = "shift:2"

-- Search settings:
-- `ignorecase`: Ignores case in search patterns.
-- `smartcase`: Overrides `ignorecase` if the search pattern contains uppercase letters (becomes case-sensitive).
-- Currently: Case-insensitive by default, but smart enough to be sensitive when needed.
-- To change: Set `ignorecase = false` for always case-sensitive search.
opt.ignorecase = true
opt.smartcase = true

-- ==============================
-- Appearance and Visual Feedback
-- ==============================

-- Terminal colors:
-- `termguicolors`: Enables true color (24-bit) support in the terminal. Essential for rich colorschemes.
-- Currently: True colors are enabled.
-- To change: Set `termguicolors = false` if your terminal doesn't support true colors or for troubleshooting.
opt.termguicolors = true

-- Background: Sets the editor background to dark or light.
-- Currently: Dark.
-- To change: Set `background = "light"` if you prefer light themes.
opt.background = "dark"

-- Sign column: The column on the left where plugins (like Git signs, LSP diagnostics) display icons.
-- `signcolumn = "yes"`: Always shows the sign column, preventing text from jumping when signs appear/disappear.
-- Currently: Always visible.
-- To change: Set to `"auto"` to show only when signs are present, or `"no"` to hide.
opt.signcolumn = "yes"

-- Highlight current line:
-- `cursorline`: Highlights the entire line where the cursor is.
-- Currently: Enabled.
-- To change: Set `cursorline = false` if you find it distracting.
opt.cursorline = true

-- Update time for CursorHold events:
-- `updatetime`: Time in milliseconds Neovim waits after the last key press before triggering `CursorHold` autocommands.
-- Many LSP features (diagnostics, hover) rely on this.
-- Currently: 300ms (very responsive).
-- To change: Increase (e.g., `500`) if you experience high CPU usage, decrease (e.g., `100`) for even faster feedback (may increase CPU).
opt.updatetime = 300

-- Timeout for key sequences:
-- `timeoutlen`: Time in milliseconds Neovim waits for a mapped key sequence to complete (e.g., `<leader>ff`).
-- Currently: 500ms.
-- To change: Decrease for snappier keybindings (e.g., `300`), increase if you type slowly or have complex mappings.
opt.timeoutlen = 500

-- Concealment level: Controls how much text is hidden/simplified by plugins (e.g., Markdown formatting).
-- `0`: No concealment.
-- `1`: Replaces concealed text with a single character (e.g., space).
-- `2`: Conceals text completely.
-- `3`: Conceals all text with the 'conceal' attribute completely.
-- Currently: Set to 3 (maximum concealment).
-- To change: Adjust to `0` for full raw text, `1` for a balance, or `2` for complete hiding.
opt.conceallevel = 3

-- Conceal cursor behavior: Controls when concealment is active on the current line.
-- `""`: Always concealed.
-- `"n"`: Concealed in Normal mode, but raw text shown in Insert/Visual mode.
-- Currently: Concealed in Normal mode, but visible when editing.
-- To change: Set to `""` to always conceal, or remove if you prefer raw text always.
opt.concealcursor = "n"

-- Line number column width: Minimum width of the line number column.
-- Currently: 4 characters.
-- To change: Adjust if your line numbers cause text to shift (e.g., `5` for files over 9999 lines).
opt.numberwidth = 4

-- Popup menu height: Maximum height of the completion popup menu (e.g., from nvim-cmp).
-- Currently: 10 lines.
-- To change: Increase to see more suggestions, decrease to save screen space.
opt.pumheight = 10

-- File encoding:
-- `fileencoding`: Encoding used when reading/writing files.
-- `encoding`: Internal encoding used by Neovim.
-- Currently: Both set to UTF-8, the modern standard.
-- To change: Rarely needed, but ensure both are UTF-8 for best compatibility.
opt.fileencoding = "utf-8"
opt.encoding = "utf-8"

-- Show mode message: Controls the `-- INSERT --` message at the bottom.
-- Currently: False, as lualine (status line plugin) already shows the mode.
-- To change: Set `showmode = true` if you want the default message back.
opt.showmode = false

-- Short messages: Suppresses or shortens various messages.
-- `c`: Suppresses completion messages.
-- Currently: Completion messages are suppressed for a cleaner command line.
-- To change: Remove `append("c")` if you want to see all completion messages.
opt.shortmess:append("c")

-- Whichwrap: Allows cursor to wrap around line ends with certain keys.
-- `<>[]hl`: Allows wrapping with arrow keys, `h`, `l`, `[` and `]`.
-- Currently: Cursor wraps seamlessly.
-- To change: Remove characters from the string (e.g., `opt.whichwrap = ""` to disable all wrapping).
opt.whichwrap:append("<>[]hl")

-- Search highlighting:
-- `hlsearch`: Highlights all matches for the last search pattern.
-- `incsearch`: Shows matches incrementally as you type your search pattern.
-- Currently: Both enabled for efficient and visual searching.
-- To change: Set to `false` for either to disable. Use `:nohlsearch` to temporarily clear highlights.
opt.hlsearch = true
opt.incsearch = true

-- Undo history:
-- `undolevels`: Maximum number of changes that can be undone.
-- `undoreload`: Maximum lines reloaded from undo file for persistent undo.
-- Currently: Set to high values (1000 changes, 10000 lines) for extensive undo history.
-- To change: Adjust if you need more/less undo history (higher values use more disk space for undo files).
opt.undolevels = 1000
opt.undoreload = 10000

-- ==============================
-- Other Core Settings
-- ==============================

-- Scrolling offset:
-- `scrolloff`: Minimum number of screen lines to keep above and below the cursor.
-- Currently: 8 lines of context.
-- To change: Adjust to your preference (e.g., `0` to keep cursor at screen edge, `999` to keep it centered).
opt.scrolloff = 8

-- Mouse support:
-- `mouse = "a"`: Enables mouse in all modes.
-- Currently: Disabled.
-- To change: Set to `"a"` to re-enable mouse interaction.
opt.mouse = ""

-- Backspace behavior:
-- `backspace`: Controls what can be deleted with backspace.
-- `indent`: Delete auto-indent.
-- `eol`: Delete end-of-line.
-- `start`: Delete characters before insert started.
-- Currently: Allows backspacing over common elements.
-- To change: Adjust if you want different backspace behavior.
opt.backspace = "indent,eol,start"

-- Clipboard integration:
-- `clipboard:append("unnamedplus")`: Integrates Neovim's clipboard with the system clipboard.
-- `unnamedplus`: Uses the system clipboard for `+` register (default for copy/paste).
-- Currently: Copy/paste works with your system clipboard.
-- To change: Remove `append("unnamedplus")` if you don't want system clipboard integration.
opt.clipboard:append("unnamedplus")

-- Split window behavior:
-- `splitright`: New vertical splits open to the right.
-- `splitbelow`: New horizontal splits open below.
-- Currently: Both disabled (splits open to the left/above by default).
-- To change: Set to `true` for either to change split direction.
opt.splitright = false
opt.splitbelow = false

-- Swapfile: A temporary file used for crash recovery.
-- Currently: False (disabled). Persistent undo (`undofile`) provides recovery.
-- To change: Set `swapfile = true` if you want traditional swap files for recovery (may clutter directories).
opt.swapfile = false

-- Persistent undo:
-- `undofile`: Enables persistent undo history (undo history saved to disk).
-- `undodir`: Directory where undo files are stored.
-- Currently: Enabled, with undo files in Neovim's data directory.
-- To change: Set `undofile = false` to disable persistent undo.
opt.undofile = true
opt.undodir = vim.fn.stdpath("data") .. "/undodir" -- Stores undo history in a dedicated directory.

