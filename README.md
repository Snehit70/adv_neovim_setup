# Advanced Neovim Configuration

<div align="center">

![Neovim](https://img.shields.io/badge/NeoVim-%2357A143.svg?&style=for-the-badge&logo=neovim&logoColor=white)
![Lua](https://img.shields.io/badge/lua-%232C2D72.svg?style=for-the-badge&logo=lua&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)

**A meticulously crafted, performance-obsessed Neovim setup built on principles of minimalism, predictability, and developer efficiency**

[Features](#-features) | [Philosophy](#-philosophy--design-principles) | [Installation](#-installation) | [Keymaps](#-key-mappings) | [Plugins](#-plugin-ecosystem)

</div>

---

## Philosophy & Design Principles

This configuration is built on a foundation of deliberate choices and strong opinions about what makes an effective development environment. Every plugin, keymap, and configuration option exists for a reason.

### Core Tenets

#### 1. **Performance Above All Else**

> "Speed is a feature. A fast editor keeps you in flow state."

- **Startup time < 50ms** - Lazy loading everything that can be lazy loaded
- **Optimized refresh rates** - Statusline at 4 FPS, not 60 FPS
- **Smart debouncing** - File watchers and updates balanced for responsiveness without waste
- **Comprehensive ignore patterns** - Never search files you don't care about
- **Async by default** - Operations that can be async, are async

#### 2. **Predictability Over Magic**

> "I want to know exactly what my editor will do, every time."

- **NO AI completions** - No Copilot, no Codeium, no unpredictable suggestions
- **Traditional LSP only** - Completions based on actual code analysis, not black boxes
- **Explicit configurations** - Every option documented, no hidden defaults
- **Deterministic behavior** - Same input = same output, always
- **Full control** - You command the editor, not the other way around

#### 3. **Minimalism Through Intention**

> "Perfection is achieved not when there is nothing more to add, but when there is nothing left to take away." - Antoine de Saint-Exupery

- **Essential plugins only** - If it doesn't solve a real problem, it's not here
- **Single colorscheme** - Catppuccin, perfectly configured, no switching overhead
- **Curated keymaps** - Every keymap serves a purpose, no conflicts, no redundancy
- **Floating UI preference** - Clean workspace with context when needed
- **Zero bloat** - No "nice to have" features that slow you down

#### 4. **Keyboard-First Workflow**

> "The mouse is for when you give up."

- **Vim motions everywhere** - hjkl navigation in every context
- **Mnemonic keymaps** - Easy to remember (`<leader>ff` = **F**ind **F**iles)
- **Modal editing mastery** - Leveraging Vim's modes for maximum efficiency
- **Which-key integration** - Never forget a keymap, discover as you type
- **No mouse dependency** - Everything achievable from home row

#### 5. **Developer Experience (DX) First**

> "Tools should get out of your way and let you build."

- **Instant feedback** - LSP, diagnostics, and git status in real-time
- **Intelligent completion** - Context-aware, properly ordered, snippet-enabled
- **Integrated problem solving** - LeetCode built-in for continuous learning
- **Git workflow support** - Stage, diff, blame without leaving editor
- **Multi-language ready** - Python, JavaScript, TypeScript, Lua, Vue, C++ configured

#### 6. **Robustness & Reliability**

> "A tool that crashes is worse than no tool at all."

- **Comprehensive error handling** - Graceful fallbacks, never crash
- **Safe defaults** - Configurations that work out of the box
- **Health checks** - Built-in diagnostics for troubleshooting
- **Dependency safety** - Protected requires, optional features
- **Battle-tested** - Real-world usage refined over time

### What This Config Is NOT

To maintain clarity of purpose, this configuration deliberately excludes:

- **AI code generation** - Unpredictable, privacy concerns, learning impediment
- **Multiple colorschemes** - Cognitive overhead, testing complexity
- **Experimental plugins** - Stability matters more than bleeding edge
- **Every LSP server** - Install what you need via Mason
- **Vim maximalism** - Not every plugin that exists needs to be here
- **Mouse-first features** - You're here to learn keyboard efficiency

### Who This Config Is For

**You should use this if you:**

- Value performance and want a fast editor
- Prefer traditional, predictable completions over AI suggestions
- Want to master keyboard-driven development
- Appreciate minimalism and intentional design
- Need a solid foundation to build upon
- Are serious about becoming a more efficient developer

**This might not be for you if you:**

- Rely heavily on AI code generation
- Prefer mouse-driven workflows
- Want every possible plugin installed
- Like customizing colorschemes frequently
- Need heavy IDE features like complex debugging GUIs

---

## Features

### **Performance**

- Lightning fast startup (< 50ms)
- Lazy loading with intelligent event triggers
- Optimized refresh rates and debouncing
- Async operations throughout
- Smart file filtering and ignore patterns

### **User Interface**

- Beautiful Catppuccin colorscheme (Mocha)
- Clean statusline with essential information
- Organized buffer tabs with management
- Floating command line and notifications
- Visual indentation guides with scope highlighting
- Rainbow delimiters for bracket matching
- Telescope with preview and multi-select

### **Language Support**

- Full LSP integration (pyright, ts_ls, lua_ls, clangd, vue_ls, eslint, ruff)
- Smart autocompletion with prioritized sources
- Treesitter syntax highlighting and text objects
- Inlay hints support
- Semantic tokens and document symbols
- Code actions and refactoring
- Auto-formatting with conform.nvim (async)

### **Navigation & Editing**

- Flash.nvim for lightning-fast jumps
- Surround operations (add/change/delete surroundings)
- Treesitter text objects for code-aware selection
- Powerful fuzzy finding with Telescope
- Git-integrated file tree with Neo-tree

### **Developer Tools**

- Integrated LeetCode environment
- Live markdown preview (browser + terminal)
- Floating terminal with multiple layouts
- Git integration (blame, diff, stage, commit)
- Real-time diagnostics and error display
- Which-key for keymap discovery

### **Workflow Optimization**

- Mnemonic keybindings
- Vim motions everywhere
- Auto-pairs and auto-tags
- System clipboard integration
- Multiple buffer/window management options

---

## Installation

### Prerequisites

```bash
# Essential dependencies
sudo apt install ripgrep fd-find xclip  # Ubuntu/Debian
sudo pacman -S ripgrep fd xclip glow    # Arch Linux
brew install ripgrep fd glow            # macOS

# A Nerd Font (recommended: JetBrainsMono Nerd Font)
# Download from: https://www.nerdfonts.com/
```

### Quick Setup

```bash
# Backup existing config (if any)
mv ~/.config/nvim ~/.config/nvim.backup

# Clone this configuration
git clone https://github.com/Snehit70/adv_neovim_setup.git ~/.config/nvim

# Launch Neovim - plugins will auto-install
nvim
```

---

## Key Mappings

### Leader Key: `<Space>`

### General

| Key | Action | Description |
| --- | ------ | ----------- |
| `<C-h/j/k/l>` | Window Navigation | Move between splits |
| `<C-Up/Down>` | Resize Height | Increase/decrease window height |
| `<C-Left/Right>` | Resize Width | Increase/decrease window width |
| `<A-j>` / `<A-k>` | Move Lines | Move current line up/down |
| `<C-s>` | Save | Save current file |
| `<Esc>` | Clear Search | Clear search highlighting |
| `<leader>L` | Lazy | Open plugin manager |
| `<leader>fn` | New File | Create new buffer |
| `<leader>qq` | Quit All | Close Neovim |
| `<leader>\`` | Alt Buffer | Switch to alternate buffer |

### File Navigation (Telescope)

| Key | Action | Description |
| --- | ------ | ----------- |
| `<leader>ff` | Find Files | Fast file search with ignore patterns |
| `<leader>fg` | Live Grep | Search text across all files |
| `<leader>fb` | Buffers | Switch between open buffers |
| `<leader>fh` | Help Tags | Search Neovim help |
| `<leader>fr` | Recent Files | Recently opened files |
| `<leader>fc` | Commands | Browse available commands |
| `<leader>fk` | Keymaps | Search all keybindings |

### File Explorer (Neo-tree)

| Key | Action | Description |
| --- | ------ | ----------- |
| `<leader>e` | Toggle Explorer | Open/close floating file tree |
| `<leader>E` | Focus Explorer | Focus on open file tree |
| **In Neo-tree:** | | |
| `<CR>` | Open | Open file/directory |
| `<Esc>` / `q` | Close | Close explorer |
| `a` | Add | Create new file |
| `d` | Delete | Remove file/folder |
| `r` | Rename | Rename item |
| `H` | Toggle Hidden | Show/hide dotfiles |
| `?` | Help | Show available mappings |
| `<BS>` | Navigate Up | Go to parent directory |
| `.` | Set Root | Set current directory as root |

### Flash (Jump/Search)

| Key | Mode | Action | Description |
| --- | ---- | ------ | ----------- |
| `s` | n, x, o | Flash Jump | Jump to any location |
| `S` | n, x, o | Flash Treesitter | Select treesitter nodes |
| `r` | o | Remote Flash | Remote action at location |
| `R` | o, x | Treesitter Search | Search and select nodes |
| `<C-s>` | c | Toggle Flash | Toggle flash in search |

### Surround

| Key | Action | Description |
| --- | ------ | ----------- |
| `ys{motion}{char}` | Add | Add surrounding (e.g., `ysiw"`) |
| `ds{char}` | Delete | Delete surrounding (e.g., `ds"`) |
| `cs{old}{new}` | Change | Change surrounding (e.g., `cs"'`) |
| `yss{char}` | Line | Surround entire line |

### Treesitter Text Objects

| Key | Action | Description |
| --- | ------ | ----------- |
| `af` / `if` | Function | Around/inside function |
| `ac` / `ic` | Class | Around/inside class |
| `aa` / `ia` | Parameter | Around/inside argument |
| `ab` / `ib` | Block | Around/inside block |
| `al` / `il` | Loop | Around/inside loop |
| `ai` / `ii` | Conditional | Around/inside if statement |
| `]m` / `[m` | Next/Prev Function | Jump to function start |
| `]]` / `[[` | Next/Prev Class | Jump to class |
| `]a` / `[a` | Next/Prev Parameter | Jump to parameter |
| `<leader>a` | Swap Next | Swap parameter with next |
| `<leader>A` | Swap Prev | Swap parameter with previous |

### LSP & Code

| Key | Action | Description |
| --- | ------ | ----------- |
| `gd` | Definition | Go to definition |
| `gD` | Declaration | Go to declaration |
| `gr` | References | Show all references |
| `gi` | Implementation | Go to implementation |
| `K` | Hover | Show documentation |
| `<C-k>` | Signature | Show function signature |
| `<leader>ca` | Code Actions | Show available fixes/refactors |
| `<leader>rn` | Rename | Rename symbol across project |
| `<leader>cf` | Format | Format current buffer (async) |
| `<leader>th` | Inlay Hints | Toggle type hints |
| `<leader>d` | Diagnostics | Line diagnostics in popup |
| `<leader>q` | Diagnostics List | All errors/warnings |
| `[d` / `]d` | Navigate | Previous/next diagnostic |

### Git Operations

| Key | Action | Description |
| --- | ------ | ----------- |
| `<leader>gf` | Git Status | Changed files (Telescope) |
| `<leader>gc` | Git Commits | Browse commit history |
| `<leader>gbc` | Buffer Commits | Commits for current file |
| `<leader>gb` | Full Blame | Full commit info |
| `<leader>gbl` | Blame Line | Inline blame for line |
| `<leader>gt` | Toggle Blame | Show/hide inline blame |
| `<leader>gd` | Diff This | Show changes |
| `<leader>gdt` | Diff This ~ | Diff against previous |
| `<leader>gD` | Diff Float | Floating diff view |
| `<leader>gS` | Stage Buffer | Stage all changes |
| `<leader>gR` | Reset Buffer | Discard all changes |
| `<leader>gts` | Toggle Signs | Show/hide git column |
| `<leader>gtd` | Toggle Deleted | Show/hide deleted lines |

### Terminal

| Key | Action | Description |
| --- | ------ | ----------- |
| `<leader>tt` | Toggle Terminal | Floating terminal |
| **In Terminal:** | | |
| `<Esc>` / `jk` | Normal Mode | Exit terminal mode |
| `<C-h/j/k/l>` | Navigate | Move to other windows |
| `<C-q>` | Close | Close terminal |

### Buffer Management

| Key | Action | Description |
| --- | ------ | ----------- |
| `<Tab>` | Next Buffer | Cycle to next buffer |
| `<S-Tab>` | Prev Buffer | Cycle to previous buffer |
| `<S-l>` | Next Buffer | Alternative next |
| `<S-h>` | Prev Buffer | Alternative previous |
| `[b` / `]b` | Navigate | Previous/next buffer |
| `<leader>bc` | Close Buffer | Close current buffer |
| `<leader>bo` | Close Others | Close all other buffers |

### Markdown

| Key | Action | Description |
| --- | ------ | ----------- |
| `<leader>mp` | Preview Toggle | Live browser preview |
| `<leader>mo` | Preview Open | Open browser preview |
| `<leader>mc` | Preview Close | Stop preview |
| `<leader>mg` | Glow Preview | Terminal preview |

### LeetCode

| Key | Action | Description |
| --- | ------ | ----------- |
| `<leader>lq` | Menu | Open LeetCode menu |
| `<leader>ll` | List | Browse all problems |
| `<leader>lle` / `llm` / `llh` | Filter | Easy/Medium/Hard |
| `<leader>ldy` | Daily | Today's challenge |
| `<leader>lrn` | Random | Random problem |
| `<leader>lt` | Test | Run test cases |
| `<leader>ls` | Submit | Submit solution |
| `<leader>lr` | Run | Execute with custom input |
| `<leader>li` | Info | Show problem details |
| `<leader>lc` | Console | Open test console |
| `<leader>ld` | Description | Toggle problem description |
| `<leader>ly` | Yank | Copy solution code |
| `<leader>llg` | Language | Change programming language |
| `<leader>lo` | Browser | Open on LeetCode.com |
| `<leader>lx` | Exit | Exit LeetCode mode |

---

## Plugin Ecosystem

### Core Framework

- **[lazy.nvim](https://github.com/folke/lazy.nvim)** - Ultra-fast plugin manager with lazy loading
- **[plenary.nvim](https://github.com/nvim-lua/plenary.nvim)** - Essential Lua utilities library

### User Interface

- **[catppuccin](https://github.com/catppuccin/nvim)** - Beautiful, highly integrated colorscheme (Mocha flavor)
- **[lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)** - Blazing fast statusline with custom components
- **[bufferline.nvim](https://github.com/akinsho/bufferline.nvim)** - Clean buffer tabs with intelligent management
- **[noice.nvim](https://github.com/folke/noice.nvim)** - Modern UI for messages, cmdline, and notifications
- **[nvim-notify](https://github.com/rcarriga/nvim-notify)** - Fancy notification manager
- **[indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)** - Indentation guides with scope highlighting
- **[which-key.nvim](https://github.com/folke/which-key.nvim)** - Keymap hints and interactive documentation

### Navigation & Editing

- **[flash.nvim](https://github.com/folke/flash.nvim)** - Lightning-fast jump and search with treesitter integration
- **[nvim-surround](https://github.com/kylechui/nvim-surround)** - Add/change/delete surroundings (brackets, quotes, tags)
- **[neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim)** - Modern file explorer with git integration
- **[telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)** - Extendable fuzzy finder with performance optimizations
- **[telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim)** - FZF sorter for telescope

### Code Intelligence

- **[nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)** - LSP configuration with server-specific optimizations
- **[mason.nvim](https://github.com/williamboman/mason.nvim)** - Automatic LSP/DAP/Linter installer
- **[mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim)** - Bridge between Mason and lspconfig
- **[mason-tool-installer.nvim](https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim)** - Auto-install formatters and linters
- **[conform.nvim](https://github.com/stevearc/conform.nvim)** - Async formatting engine
- **[nvim-cmp](https://github.com/hrsh7th/nvim-cmp)** - Completion engine (LSP-only, NO AI)
  - **cmp-nvim-lsp** - LSP completion source
  - **cmp-nvim-lua** - Neovim Lua API completion
  - **cmp-buffer** - Buffer words completion
  - **cmp-path** - Filesystem path completion
  - **cmp-cmdline** - Command-line completion
  - **LuaSnip** - Snippet engine
  - **cmp_luasnip** - Snippet completion
  - **friendly-snippets** - Pre-configured snippets
- **[nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)** - Advanced syntax highlighting and code understanding
- **[nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects)** - Treesitter-based text objects
- **[rainbow-delimiters.nvim](https://github.com/hiphish/rainbow-delimiters.nvim)** - Rainbow brackets for nested code

### Development Tools

- **[gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)** - Git decorations, hunk management, and blame
- **[nvim-autopairs](https://github.com/windwp/nvim-autopairs)** - Auto-close brackets, quotes, and tags
- **[nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag)** - Auto-close and rename HTML/XML tags
- **[toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim)** - Floating terminal integration

### Specialized Tools

- **[leetcode.nvim](https://github.com/kawre/leetcode.nvim)** - Complete LeetCode environment (browse, solve, test, submit)
- **[markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim)** - Live markdown preview in browser
- **[glow.nvim](https://github.com/ellisonleao/glow.nvim)** - Terminal-based markdown preview

---

## Language Server Configuration

### Auto-Installed LSP Servers

These servers are automatically installed via Mason when you first open Neovim:

| Server | Language | Features |
| ------ | -------- | -------- |
| **lua_ls** | Lua | Neovim API completion, inlay hints |
| **pyright** | Python | Type checking, workspace analysis |
| **ruff** | Python | Fast linting and quickfixes |
| **ts_ls** | TypeScript/JavaScript | Full inlay hints, Vue plugin support |
| **vue_ls** | Vue.js | Single-file component support |
| **eslint** | JS/TS/Vue | Linting integration |
| **clangd** | C/C++ | clang-tidy, header insertion, background indexing |

### Auto-Installed Formatters & Linters

| Tool | Languages |
| ---- | --------- |
| **stylua** | Lua |
| **ruff** | Python |
| **prettierd** | JS, TS, Vue, CSS, HTML, JSON, YAML, Markdown |
| **clang-format** | C, C++ |
| **jdtls** | Java |

### Installing Additional Servers

Additional servers can be installed via Mason and will work automatically:

```vim
:Mason
" Select server and press 'i' to install
```

### Features per Language

**All languages get:**

- Auto-completion with snippets
- Go to definition/references/implementation
- Hover documentation
- Rename refactoring
- Code actions
- Diagnostics with virtual text
- Document symbols navigation

**Enhanced features (where supported):**

- Inlay hints (types, parameters, return values)
- Semantic highlighting
- Signature help in real-time

---

## Performance Optimizations

### Startup Performance

- **Lazy loading everything** - Plugins load on-demand (file type, command, keymap)
- **Optimized event triggers** - Smart use of `BufReadPost`, `BufNewFile` vs `VeryLazy`
- **Minimal dependencies** - No redundant plugins or unused features
- **Fast plugin manager** - lazy.nvim is faster than packer and vim-plug combined
- **Target: < 50ms startup** - Achievable on modern hardware

### Runtime Performance

- **Reduced refresh rates**
  - Statusline: 250ms (4 FPS) instead of 60 FPS
  - Tabline: 1000ms (1 FPS)
  - Only updates on meaningful events
- **Debounced file watchers** - LSP and git updates are intelligently throttled
- **Async operations** - File formatting, LSP requests don't block editor
- **Smart directory scanning** - Shallow scan mode in neo-tree
- **Optimized ignore patterns** - Never process unnecessary files

### Search Performance

- **Comprehensive ignore patterns**
  - `node_modules`, `__pycache__`, `target`, `.git`, etc.
  - Language-specific artifacts (`.pyc`, `.o`, `.class`)
  - Editor/OS files (`.DS_Store`, `.swp`, `.idea`)
- **Fast search tools** - `ripgrep` and `fd` for blazing fast results
- **Telescope optimizations** - Cache, debounce, and smart defaults

### LSP Performance

- **Server-specific optimizations** - Custom configs per language server
- **Semantic tokens** - Enabled selectively for better highlighting
- **Max file length limits** - Skip gitsigns on huge files (10k+ lines)

### Memory Efficiency

- **No AI models loaded** - No copilot, no codeium, no LLM overhead
- **Single colorscheme** - No multiple theme files loaded
- **Cleanup on buffer close** - Proper resource management
- **Optimized treesitter** - Only installed languages parsed

---

## What's NOT Included (By Design)

This configuration intentionally excludes certain features to maintain its philosophy:

### AI Code Completion Tools

- **No GitHub Copilot** - Unpredictable suggestions, privacy concerns, learning impediment
- **No Codeium/TabNine/etc.** - Black box completions, requires internet, trust issues
- **Why?** - Traditional LSP provides predictable, context-aware completions based on actual code analysis.

### Complex Debugging GUIs

- **No nvim-dap UI** - Terminal debugging is sufficient for most use cases
- **Why?** - Adds complexity and keybindings. Print debugging and LSP are enough for 95% of debugging tasks.

### Multiple Colorschemes

- **Only Catppuccin** - One well-configured theme
- **Why?** - Theme switching adds cognitive overhead and testing complexity.

### Git GUI Plugins

- **No lazygit.nvim/neogit** - gitsigns + terminal git is enough
- **Why?** - Learning git CLI is more valuable.

### Dashboard/Start Screens

- **No alpha/dashboard** - Opens to files immediately
- **Why?** - You're here to code, not admire ASCII art.

### Session Management

- **No auto-session/persistence** - Manual session control via `:mksession`
- **Why?** - Automatic session restore can be confusing. Explicit is better than implicit.

### Every Possible LSP Server

- **Install what you need** - Via `:Mason` when needed
- **Why?** - Not every developer needs every language. On-demand installation keeps things lean.

### Test Runners/DAP

- **Use terminal commands** - `pytest`, `cargo test`, `go test`, etc.
- **Why?** - Language-specific test runners are better learned in their native environment.

### What You Get Instead

- **Speed** - No bloat means faster everything
- **Predictability** - No surprises, no mysteries
- **Learning** - Forces you to understand your tools
- **Reliability** - Fewer dependencies, fewer breakages
- **Focus** - Purpose-built for efficient coding

---

## Customization

### Adding Language Servers

Edit `lua/plugins/lsp_config.lua`:

```lua
mason_lspconfig.setup({
  ensure_installed = {
    "lua_ls",
    "pyright",
    "your_language_server", -- Add here
  },
})
```

### Changing Colorscheme

Edit `lua/plugins/colorscheme.lua` to modify Catppuccin flavor or switch themes.

### Adding Plugins

Create new files in `lua/plugins/` following the lazy.nvim specification:

```lua
-- lua/plugins/your_plugin.lua
return {
  "author/plugin-name",
  config = function()
    -- Plugin configuration
  end,
}
```

### Adding Formatters

Edit `lua/plugins/formatting.lua`:

```lua
formatters_by_ft = {
  lua = { "stylua" },
  python = { "ruff_fix", "ruff_organize_imports", "ruff_format" },
  your_language = { "your_formatter" },
}
```

---

## Troubleshooting

### Common Issues

1. **Slow startup** - Run `:Lazy profile` to identify problematic plugins
2. **LSP not working** - Check `:Mason` for server installation status
3. **Telescope errors** - Ensure `ripgrep` and `fd` are installed
4. **Missing icons** - Install a Nerd Font and set it in your terminal
5. **Glow not working** - Install `glow` CLI tool

### Health Checks

```vim
:checkhealth          " General Neovim health
:checkhealth telescope " Telescope-specific health
:checkhealth mason     " Mason-specific health
```

---

## License

MIT License - Feel free to fork and customize for your needs!

---

## Acknowledgments

This configuration is built on the shoulders of giants:

### Inspiration & Learning

- The Neovim community for incredible plugin ecosystem
- [ThePrimeagen](https://github.com/ThePrimeagen) for emphasizing speed and keyboard efficiency
- [TJ DeVries](https://github.com/tjdevries) for advancing Neovim and Telescope
- [Folke Lemaitre](https://github.com/folke) for revolutionary plugins (lazy.nvim, which-key, noice, flash.nvim)

### Built For

Developers who want to:

- Master their tools instead of being mastered by them
- Code faster by removing friction
- Learn deeply by understanding what they use
- Build a sustainable, long-term development environment

---

**"Perfection is achieved not when there is nothing more to add, but when there is nothing left to take away."**

_Happy Coding!_

</div>
