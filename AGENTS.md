# Neovim Configuration Agent Guidelines (AGENTS.md)

This file provides context and rules for AI agents operating in this Neovim configuration.

## 1. Environment & Architecture

- **Context**: Personal Neovim configuration optimized for performance and keyboard-driven development.
- **Runtime**: Neovim 0.9+ with Lua configuration.
- **Plugin Manager**: `lazy.nvim` (lazy loading by default).
- **Core Structure**:
  - `init.lua`: Minimal bootstrap (loads config modules).
  - `lua/config/`: Core settings (`options.lua`, `keymaps.lua`, `lazy.lua`).
  - `lua/plugins/`: Individual plugin specifications (auto-imported by lazy.nvim).
  - `ftplugin/`: Filetype-specific configurations (e.g., `java.lua`).
  - `lua/snippets/`: Custom snippets (e.g., `cpp.lua`).

## 2. Philosophy & Design Principles

### Core Tenets

1. **Performance Above All Else**
   - Target: **< 50ms startup time**
   - Lazy loading everything possible
   - Optimized refresh rates (statusline: 250ms, tabline: 1000ms)
   - Async operations by default
   - Comprehensive ignore patterns for searches

2. **Predictability Over Magic**
   - **NO AI completions** (no Copilot, Codeium, etc.)
   - Traditional LSP-only completions
   - Explicit configurations, no hidden defaults
   - Deterministic behavior

3. **Minimalism Through Intention**
   - Essential plugins only
   - Single colorscheme (Catppuccin Mocha)
   - Curated keymaps with no conflicts
   - Zero bloat

4. **Keyboard-First Workflow**
   - Vim motions everywhere
   - Mnemonic keymaps (`<leader>ff` = Find Files)
   - Modal editing mastery
   - Which-key integration for discoverability
   - **Mouse disabled** (`opt.mouse = ""`)

5. **Developer Experience First**
   - Instant LSP feedback
   - Intelligent completion (context-aware, snippet-enabled)
   - Integrated tools (LeetCode, Git, Markdown preview)
   - Multi-language ready (Python, JS/TS, Lua, Vue, C++, Java)

### What This Config Is NOT

- **No AI code generation** - Unpredictable, privacy concerns
- **No multiple colorschemes** - Cognitive overhead
- **No experimental plugins** - Stability matters
- **No mouse-first features** - Keyboard efficiency focus
- **No test infrastructure** - Removed for simplicity

## 3. File Organization

```
~/.config/nvim/
├── init.lua                    # Entry point (loads config modules)
├── lua/
│   ├── config/
│   │   ├── options.lua         # Vim options and settings
│   │   ├── keymaps.lua         # Global keymaps
│   │   └── lazy.lua            # lazy.nvim bootstrap and setup
│   ├── plugins/                # Plugin specifications (auto-imported)
│   │   ├── colorscheme.lua
│   │   ├── lsp_config.lua
│   │   ├── cmp.lua
│   │   ├── telescope.lua
│   │   ├── treesitter_config.lua
│   │   ├── gitsigns_config.lua
│   │   ├── leetcode.lua
│   │   └── ...
│   └── snippets/               # Custom snippets
│       └── cpp.lua
├── ftplugin/                   # Filetype-specific configs
│   └── java.lua
└── README.md                   # User-facing documentation
```

## 4. Plugin Architecture (lazy.nvim)

### Plugin Loading Strategy

- **Default**: `lazy = true` (plugins load on-demand)
- **Exceptions**: `plenary.nvim` (loaded immediately for Telescope dependency)
- **Triggers**: Event (`BufReadPost`, `VeryLazy`), Command, Keymap, Filetype

### Plugin Specification Pattern

Each plugin file in `lua/plugins/` returns a table:

```lua
-- lua/plugins/example.lua
return {
  "author/plugin-name",
  event = "VeryLazy",  -- or cmd, keys, ft, etc.
  dependencies = { "dependency/plugin" },
  opts = {
    -- Plugin options (passed to setup())
  },
  config = function()
    -- Custom configuration
    require("plugin-name").setup({
      -- options
    })
  end,
}
```

### Adding New Plugins

1. Create new file in `lua/plugins/plugin_name.lua`
2. Follow lazy.nvim specification format
3. Use lazy loading (event, cmd, keys, ft)
4. Document keymaps in plugin config or `which_key_config.lua`
5. Test startup time: `:Lazy profile`

### Disabled Built-in Plugins

For performance, these are disabled in `lua/config/lazy.lua`:

```lua
disabled_plugins = {
  "gzip", "matchit", "matchparen", "netrwPlugin",
  "tarPlugin", "tohtml", "tutor", "zipPlugin",
}
```

## 5. Code Style & Conventions

### Lua Style

- **Indentation**: 2 spaces (enforced by `stylua`)
- **Quotes**: Double quotes preferred
- **Local variables**: Use `local` for all variables
- **Naming**: `snake_case` for variables/functions, `PascalCase` for modules
- **Comments**: `--` for single-line, document complex logic

### Keymap Conventions

- **Leader key**: `<Space>`
- **Local leader**: `<Space>` (same as leader)
- **Naming pattern**: Mnemonic prefixes
  - `<leader>f` = Find (Telescope)
  - `<leader>g` = Git
  - `<leader>l` = LeetCode
  - `<leader>m` = Markdown
  - `<leader>t` = Terminal/Toggle
  - `<leader>c` = Code (LSP actions)
  - `<leader>b` = Buffer

### Keymap Definition Pattern

```lua
local map = vim.keymap.set

map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })
--  ^mode  ^key         ^action                            ^description (for which-key)
```

**Rules**:
- Always include `desc` for which-key integration
- Use `<cmd>...<cr>` for commands (faster than `:...`)
- Group related keymaps by prefix
- No conflicting keymaps

## 6. LSP Configuration

### Auto-Installed LSP Servers (Mason)

Defined in `lua/plugins/lsp_config.lua`:

```lua
ensure_installed = {
  "lua_ls",      -- Lua (Neovim API completion)
  "pyright",     -- Python (type checking)
  "ruff",        -- Python (linting)
  "ts_ls",       -- TypeScript/JavaScript
  "vue_ls",      -- Vue.js
  "eslint",      -- JS/TS/Vue linting
  "clangd",      -- C/C++
}
```

### LSP Keymaps (Standard)

Defined in `lua/plugins/lsp_config.lua`:

```lua
gd  = Go to Definition
gD  = Go to Declaration
gr  = References
gi  = Implementation
K   = Hover Documentation
<C-k> = Signature Help
<leader>ca = Code Actions
<leader>rn = Rename Symbol
<leader>cf = Format Buffer
[d / ]d = Navigate Diagnostics
```

### Adding New LSP Servers

1. Add server name to `ensure_installed` in `lua/plugins/lsp_config.lua`
2. Configure server-specific options in `lspconfig[server].setup({})`
3. Install via `:Mason` or restart Neovim (auto-installs)

## 7. Formatting Configuration

### Formatter Setup (conform.nvim)

Defined in `lua/plugins/formatting.lua`:

```lua
formatters_by_ft = {
  lua = { "stylua" },
  python = { "ruff_fix", "ruff_organize_imports", "ruff_format" },
  javascript = { "prettierd" },
  typescript = { "prettierd" },
  vue = { "prettierd" },
  cpp = { "clang-format" },
  -- Add more as needed
}
```

### Format on Save

- **Disabled by default** (manual format with `<leader>cf`)
- To enable: Set `format_on_save = true` in `lua/plugins/formatting.lua`

## 8. Options & Settings

### Key Settings (lua/config/options.lua)

```lua
-- Indentation
tabstop = 2, shiftwidth = 2, expandtab = true

-- Line numbers
number = true, relativenumber = true

-- Search
ignorecase = true, smartcase = true

-- UI
termguicolors = true, cursorline = true, signcolumn = "yes"

-- Performance
updatetime = 300, timeoutlen = 300

-- Clipboard
clipboard = "unnamedplus" (system clipboard integration)

-- Mouse
mouse = "" (DISABLED)

-- Undo
undofile = true (persistent undo in ~/.local/share/nvim/undodir/)
swapfile = false (no swap files)
```

### Filetype-Specific Overrides

C/C++ enforces 2 spaces (autocmd in `options.lua`):

```lua
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
  end,
})
```

## 9. Git & Workflow

### Commit Standards

- **Format**: Conventional Commits (`feat:`, `fix:`, `chore:`, `refactor:`, `docs:`)
- **Length**: One-line only (max 72 chars)
- **Style**: Lowercase, imperative mood ("add feature" not "added feature")
- **Ban**: No AI watermarks ("Generated by Claude")

### Branching Strategy

- **Feature branches**: `feat/feature-name`
- **Fix branches**: `fix/bug-name`
- **No direct commits to main**

### Testing Approach

- **No automated tests** (test infrastructure removed)
- **Manual verification**: Test changes in live Neovim session
- **Health checks**: `:checkhealth`, `:checkhealth telescope`, `:checkhealth mason`
- **Startup profiling**: `:Lazy profile`

## 10. Debugging & Troubleshooting

### Common Issues

1. **Slow startup** → `:Lazy profile` to identify problematic plugins
2. **LSP not working** → `:Mason` to check server installation
3. **Telescope errors** → Ensure `ripgrep` and `fd` are installed
4. **Missing icons** → Install a Nerd Font
5. **Glow not working** → Install `glow` CLI tool

### Health Checks

```vim
:checkhealth          " General Neovim health
:checkhealth telescope " Telescope-specific
:checkhealth mason     " Mason-specific
:LspInfo              " LSP server status
```

### Log Files

- **LSP logs**: `:LspLog` or `~/.local/state/nvim/lsp.log`
- **Lazy.nvim logs**: `:Lazy log`

## 11. Workflow Rules for Agents

### Safety First

- **Read before edit**: Always read files before modifying
- **Preserve structure**: Maintain existing patterns and organization
- **Test changes**: Verify with `:checkhealth` and manual testing
- **No breaking changes**: Don't remove plugins without understanding dependencies

### Adding Features

1. **Research first**: Check if plugin already exists in config
2. **Lazy loading**: Always use event/cmd/keys triggers
3. **Document keymaps**: Add to which-key or plugin config
4. **Test startup**: Ensure < 50ms target maintained

### Modifying Plugins

1. **Read plugin file first**: Understand current configuration
2. **Preserve lazy loading**: Don't change loading strategy without reason
3. **Update keymaps**: If changing commands, update keymap descriptions
4. **Check dependencies**: Ensure no other plugins depend on removed features

### Commit Protocol

- **Always ask before committing** (never auto-commit)
- **Use conventional commits** format
- **One logical change per commit**
- **Test before committing** (manual verification)

## 12. Tech Stack Overview

- **Editor**: Neovim 0.9+
- **Language**: Lua 5.1 (LuaJIT)
- **Plugin Manager**: lazy.nvim
- **LSP Manager**: Mason
- **Completion**: nvim-cmp (LSP-only, no AI)
- **Fuzzy Finder**: Telescope (with fzf-native)
- **Syntax**: Treesitter
- **Colorscheme**: Catppuccin (Mocha)
- **Formatter**: conform.nvim
- **Git**: gitsigns.nvim
- **Terminal**: toggleterm.nvim

## 13. Dependencies (External Tools)

### Required

- `ripgrep` (rg) - Fast search for Telescope
- `fd` (fd-find) - Fast file finder for Telescope
- `git` - Version control

### Optional

- `xclip` / `xsel` - Clipboard integration (Linux)
- `glow` - Terminal markdown preview
- Nerd Font - Icons in UI

### Installation

```bash
# Ubuntu/Debian
sudo apt install ripgrep fd-find xclip glow

# Arch Linux
sudo pacman -S ripgrep fd xclip glow

# macOS
brew install ripgrep fd glow
```

## 14. Performance Targets

- **Startup time**: < 50ms (measure with `nvim --startuptime startup.log`)
- **Lazy loading**: All plugins except plenary
- **Refresh rates**: Statusline 250ms, Tabline 1000ms
- **File size limits**: Gitsigns disabled for files > 10k lines

## 15. Interaction Guidelines for Agents

- **Role**: Senior Software Engineer working on personal Neovim config
- **Tone**: Concise, direct, technical
- **Transparency**: Explain reasoning for changes
- **Ask before**: Removing plugins, changing core settings, committing
- **Never**: Add AI completion plugins, enable mouse, add bloat

---

**Last Updated**: 2026-01-25
**Maintainer**: Snehit (SF Bay Area)
**Philosophy**: "Perfection is achieved not when there is nothing more to add, but when there is nothing left to take away."
