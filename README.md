# 🚀 Advanced Neovim Configuration

<div align="center">

![Neovim](https://img.shields.io/badge/NeoVim-%2357A143.svg?&style=for-the-badge&logo=neovim&logoColor=white)
![Lua](https://img.shields.io/badge/lua-%232C2D72.svg?style=for-the-badge&logo=lua&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)

**A meticulously crafted, performance-obsessed Neovim setup built on principles of minimalism, predictability, and developer efficiency**

[Features](#-features) • [Philosophy](#-philosophy--design-principles) • [Installation](#-installation) • [Keymaps](#️-key-mappings) • [Plugins](#-plugin-ecosystem)

</div>

---

## 🎯 Philosophy & Design Principles

This configuration is built on a foundation of deliberate choices and strong opinions about what makes an effective development environment. Every plugin, keymap, and configuration option exists for a reason.

### Core Tenets

#### 1. **Performance Above All Else** ⚡
> "Speed is a feature. A fast editor keeps you in flow state."

- **Startup time < 50ms** - Lazy loading everything that can be lazy loaded
- **Optimized refresh rates** - Statusline at 4 FPS, not 60 FPS
- **Smart debouncing** - File watchers and updates balanced for responsiveness without waste
- **Comprehensive ignore patterns** - Never search files you don't care about
- **Async by default** - Operations that can be async, are async

#### 2. **Predictability Over Magic** 🎯
> "I want to know exactly what my editor will do, every time."

- **NO AI completions** - No Copilot, no Codeium, no unpredictable suggestions
- **Traditional LSP only** - Completions based on actual code analysis, not black boxes
- **Explicit configurations** - Every option documented, no hidden defaults
- **Deterministic behavior** - Same input = same output, always
- **Full control** - You command the editor, not the other way around

#### 3. **Minimalism Through Intention** 🎨
> "Perfection is achieved not when there is nothing more to add, but when there is nothing left to take away." - Antoine de Saint-Exupéry

- **Essential plugins only** - If it doesn't solve a real problem, it's not here
- **Single colorscheme** - Catppuccin, perfectly configured, no switching overhead
- **Curated keymaps** - Every keymap serves a purpose, no conflicts, no redundancy
- **Floating UI preference** - Clean workspace with context when needed
- **Zero bloat** - No "nice to have" features that slow you down

#### 4. **Keyboard-First Workflow** ⌨️
> "The mouse is for when you give up."

- **Vim motions everywhere** - hjkl navigation in every context
- **Mnemonic keymaps** - Easy to remember (`<leader>ff` = **F**ind **F**iles)
- **Modal editing mastery** - Leveraging Vim's modes for maximum efficiency
- **Which-key integration** - Never forget a keymap, discover as you type
- **No mouse dependency** - Everything achievable from home row

#### 5. **Developer Experience (DX) First** 🛠️
> "Tools should get out of your way and let you build."

- **Instant feedback** - LSP, diagnostics, and git status in real-time
- **Intelligent completion** - Context-aware, properly ordered, snippet-enabled
- **Integrated problem solving** - LeetCode built-in for continuous learning
- **Git workflow support** - Stage, diff, blame without leaving editor
- **Multi-language ready** - Python, JavaScript, TypeScript, Lua, Rust, Go, C++ configured

#### 6. **Robustness & Reliability** 🛡️
> "A tool that crashes is worse than no tool at all."

- **Comprehensive error handling** - Graceful fallbacks, never crash
- **Safe defaults** - Configurations that work out of the box
- **Health checks** - Built-in diagnostics for troubleshooting
- **Dependency safety** - Protected requires, optional features
- **Battle-tested** - Real-world usage refined over time

### What This Config Is NOT

To maintain clarity of purpose, this configuration deliberately excludes:

- ❌ **AI code generation** - Unpredictable, privacy concerns, learning impediment
- ❌ **Multiple colorschemes** - Cognitive overhead, testing complexity
- ❌ **Experimental plugins** - Stability matters more than bleeding edge
- ❌ **Every LSP server** - Install what you need via Mason
- ❌ **Vim maximalism** - Not every plugin that exists needs to be here
- ❌ **Mouse-first features** - You're here to learn keyboard efficiency

### Who This Config Is For

✅ **You should use this if you:**
- Value performance and want a fast editor
- Prefer traditional, predictable completions over AI suggestions
- Want to master keyboard-driven development
- Appreciate minimalism and intentional design
- Need a solid foundation to build upon
- Are serious about becoming a more efficient developer

❌ **This might not be for you if you:**
- Rely heavily on AI code generation
- Prefer mouse-driven workflows
- Want every possible plugin installed
- Like customizing colorschemes frequently
- Need heavy IDE features like complex debugging GUIs

---

## ✨ Features

### 🚀 **Performance**
- ⚡ Lightning fast startup (< 50ms)
- 🔄 Lazy loading with intelligent event triggers
- 📊 Optimized refresh rates and debouncing
- 🎯 Async operations throughout
- 🗂️ Smart file filtering and ignore patterns

### 🎨 **User Interface**
- 🌙 Beautiful Catppuccin colorscheme (Mocha)
- 📍 Clean statusline with essential information
- 📑 Organized buffer tabs with management
- 💬 Floating command line and notifications
- 🎯 Visual indentation guides with scope highlighting
- 🔍 Telescope with preview and multi-select

### 🔧 **Language Support**
- 🧠 Full LSP integration (pyright, ts_ls, lua_ls, rust_analyzer, gopls, clangd, etc.)
- ⚡ Smart autocompletion with prioritized sources
- 🌲 Treesitter syntax highlighting
- 📝 Inlay hints support (TypeScript, Rust, Go)
- � Semantic tokens and document symbols
- 🛠️ Code actions and refactoring
- 📐 Auto-formatting with async support

### 🗂️ **File Management**
- 📁 Multi-source file explorer (files, buffers, git status, symbols)
- 🔍 Powerful fuzzy finding with Telescope
- 🌲 Git-integrated file tree
- 📊 File size, timestamps, and diagnostics display
- 🔗 Symlink support and path operations

### 🎮 **Developer Tools**
- 🏆 Integrated LeetCode environment
- 📝 Live markdown preview with math and diagrams
- 💻 Floating terminal with multiple layouts
- 🔀 Git integration (blame, diff, stage, commit)
- 💡 Real-time diagnostics and error display
- 📚 Which-key for keymap discovery

### 🎯 **Workflow Optimization**
- ⌨️ Mnemonic keybindings
- 🔄 Vim motions everywhere
- 🎨 Comment toggling with context awareness
- � Auto-pairs and auto-tags
- 📋 System clipboard integration
- 🎪 Multiple buffer/window management options

---

## 🛠️ Philosophy

This configuration prioritizes:
- **Speed over features** - Only essential functionality, highly optimized
- **Predictability over AI** - Traditional LSP-based completions, no AI interference  
- **Keyboard-first workflow** - Minimal mouse dependency, vim-like navigation
- **Floating UI** - Modern popup-based interface for better focus

---

## 📦 Installation

### Prerequisites

```bash
# Essential dependencies
sudo apt install ripgrep fd-find xclip  # Ubuntu/Debian
brew install ripgrep fd               # macOS

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

## ⌨️ Key Mappings

### Leader Key: `<Space>`

#### 🔍 **File Navigation (Telescope)**
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>ff` | Find Files | Fast file search with ignore patterns |
| `<leader>fg` | Live Grep | Search text across all files |
| `<leader>fb` | Find Buffers | Switch between open buffers |
| `<leader>fh` | Help Tags | Search Neovim help |
| `<leader>fo` | Old Files | Recently opened files |
| `<leader>fc` | Commands | Browse available commands |
| `<leader>fk` | Keymaps | Search all keybindings |
| `<leader>fs` | Grep String | Search word under cursor |
| `<leader>fr` | Resume Last | Continue previous search |
| `<leader>gf` | Git Status | Changed files (Telescope) |
| `<leader>gc` | Git Commits | Browse commit history |
| `<leader>gbc` | Buffer Commits | Commits for current file |

#### 📁 **File Explorer (Neo-tree)**
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>e` | Toggle Explorer | Open/close floating file tree |
| `<leader>E` | Focus Explorer | Focus on open file tree |
| `<leader>ge` | Git Status Explorer | View git changes |
| `<leader>be` | Buffer Explorer | Browse open buffers |
| `<leader>se` | Symbols Explorer | Navigate document symbols |
| **In Neo-tree:** | | |
| `h` / `l` | Close/Open Node | Navigate tree |
| `a` / `A` | Add File/Directory | Create new items |
| `d` | Delete | Remove file/folder |
| `r` | Rename | Rename item |
| `y` / `x` / `p` | Copy/Cut/Paste | Clipboard operations |
| `Y` / `gy` | Copy Path | Absolute/relative path |
| `/` | Fuzzy Find | Search in tree |
| `H` | Toggle Hidden | Show/hide dotfiles |
| `ga` / `gu` | Git Add/Unstage | Git operations |
| `<C-f>` / `<C-g>` | Telescope Find/Grep | Search in directory |

#### 💻 **Terminal**
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>tt` | Toggle Terminal | Floating terminal for commands |

#### 🔧 **LSP & Code**
| Key | Action | Description |
|-----|--------|-------------|
| `gd` | Go to Definition | Jump to symbol definition |
| `gD` | Go to Declaration | Jump to symbol declaration |
| `gr` | Go to References | Show all references |
| `gi` | Go to Implementation | Jump to implementation |
| `K` | Hover Documentation | Show symbol docs |
| `<C-k>` | Signature Help | Show function signature |
| `<leader>ca` | Code Actions | Show available fixes/refactors |
| `<leader>rn` | Rename Symbol | Rename across entire project |
| `<leader>cf` | Format Code | Format current buffer (async) |
| `<leader>cl` | Run CodeLens | Execute code lens action |
| `<leader>th` | Toggle Inlay Hints | Show/hide type hints |
| `<leader>d` | Line Diagnostics | Error details in popup |
| `<leader>q` | Diagnostics List | All errors/warnings |
| `[d` / `]d` | Prev/Next Diagnostic | Navigate diagnostics |
| `[g` / `]g` | Prev/Next Git Hunk | Navigate git changes |

#### 📚 **LeetCode**
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>lq` | LeetCode Menu | Open problem browser |
| `<leader>ll` | List Problems | Browse all problems |
| `<leader>lle` / `llm` / `llh` | Filter by Difficulty | Easy/Medium/Hard |
| `<leader>ldy` | Daily Problem | Today's challenge |
| `<leader>lrn` | Random Problem | Practice random |
| `<leader>lt` | Test Solution | Run test cases |
| `<leader>ls` | Submit Solution | Submit to LeetCode |
| `<leader>lr` | Run Solution | Execute with custom input |
| `<leader>li` | Problem Info | Show problem details |
| `<leader>lc` | Console | Open test console |
| `<leader>ld` | Toggle Description | Show/hide problem |
| `<leader>ly` | Yank Code | Copy solution |
| `<leader>llg` | Change Language | Switch programming language |
| `<leader>lo` | Open in Browser | View on LeetCode.com |

#### 🎨 **Git Operations**
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>gb` | Git Blame | Full commit info |
| `<leader>gbl` | Blame Line | Inline blame for line |
| `<leader>gt` | Toggle Blame | Show/hide inline blame |
| `<leader>gd` | Diff This | Show changes |
| `<leader>gS` | Stage Buffer | Stage all changes |
| `<leader>gR` | Reset Buffer | Discard all changes |
| `<leader>gts` | Toggle Signs | Show/hide git column |
| `[g` / `]g` | Prev/Next Hunk | Navigate changes |

#### 📖 **Markdown**
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>mp` | Preview Toggle | Live markdown preview |

#### 🗂️ **Buffer Management**
| Key | Action | Description |
|-----|--------|-------------|
| `<Tab>` | Next Buffer | Cycle to next buffer |
| `<S-Tab>` | Previous Buffer | Cycle to previous buffer |
| `<leader>bc` | Close Buffer | Close current buffer |
| `<leader>bo` | Close Others | Close all other buffers |
| `<leader>br` | Close Right | Close buffers to right |
| `<leader>bl` | Close Left | Close buffers to left |
| `<leader>bp` | Pick Buffer | Interactive buffer picker |

#### 🪟 **Window Management**
| Key | Action | Description |
|-----|--------|-------------|
| `<C-w>s` / `<leader>ws` | Split Below | Horizontal split |
| `<C-w>v` / `<leader>wv` | Split Right | Vertical split |
| `<C-w>c` / `<leader>wd` | Close Window | Close current window |
| `<C-w>o` | Close Others | Close all other windows |
| `<C-w>h/j/k/l` | Focus Window | Navigate splits |
| `<C-w>=` / `<leader>w=` | Equal Size | Balance window sizes |
| `<C-w>|` / `<leader>w|` | Max Width | Maximize width |
| `<C-w>_` / `<leader>w_` | Max Height | Maximize height |

---

## 🔌 Plugin Ecosystem

### Core Framework
- **[lazy.nvim](https://github.com/folke/lazy.nvim)** - Ultra-fast plugin manager with lazy loading
- **[plenary.nvim](https://github.com/nvim-lua/plenary.nvim)** - Essential Lua utilities library

### User Interface  
- **[catppuccin](https://github.com/catppuccin/nvim)** - Beautiful, highly integrated colorscheme (Mocha flavor)
- **[lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)** - Blazing fast statusline with custom components
- **[bufferline.nvim](https://github.com/akinsho/bufferline.nvim)** - Clean buffer tabs with intelligent management
- **[noice.nvim](https://github.com/folke/noice.nvim)** - Modern UI for messages, cmdline, and notifications
- **[indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)** - Indentation guides with scope highlighting
- **[which-key.nvim](https://github.com/folke/which-key.nvim)** - Keymap hints and interactive documentation

### File Management
- **[neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim)** - Multi-source file explorer (files, buffers, git, symbols)
- **[telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)** - Extendable fuzzy finder with performance optimizations

### Code Intelligence
- **[nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)** - LSP configuration with server-specific optimizations
- **[mason.nvim](https://github.com/williamboman/mason.nvim)** - Automatic LSP/DAP/Linter installer
- **[mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim)** - Bridge between Mason and lspconfig
- **[nvim-cmp](https://github.com/hrsh7th/nvim-cmp)** - Completion engine (LSP-only, NO AI)
  - **cmp-nvim-lsp** - LSP completion source
  - **cmp-buffer** - Buffer words completion
  - **cmp-path** - Filesystem path completion
  - **cmp-cmdline** - Command-line completion
  - **LuaSnip** - Snippet engine
  - **cmp_luasnip** - Snippet completion
  - **friendly-snippets** - Pre-configured snippets
- **[nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)** - Advanced syntax highlighting and code understanding

### Development Tools
- **[gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)** - Git decorations, hunk management, and blame
- **[Comment.nvim](https://github.com/numToStr/Comment.nvim)** - Smart commenting with treesitter integration
- **[nvim-autopairs](https://github.com/windwp/nvim-autopairs)** - Auto-close brackets, quotes, and tags
- **[nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag)** - Auto-close and rename HTML/XML tags
- **[toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim)** - Multiple terminal integration with layouts

### Specialized Tools
- **[leetcode.nvim](https://github.com/kawre/leetcode.nvim)** - Complete LeetCode environment (browse, solve, test, submit)
- **[markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim)** - Live markdown preview with math and diagrams

---

## 🎯 Language Server Configuration

### Pre-configured LSP Servers

This configuration includes server-specific optimizations for:

#### **Systems Programming**
- **clangd** - C/C++ with clang-tidy, header insertion, background indexing
- **rust_analyzer** - Rust with clippy, comprehensive inlay hints

#### **Web Development**
- **ts_ls/tsserver** - TypeScript/JavaScript with full inlay hints
- **html** - HTML language server
- **cssls** - CSS/SCSS/LESS language server
- **emmet_ls** - Emmet abbreviations for HTML/CSS
- **tailwindcss** - Tailwind CSS IntelliSense

#### **Backend Languages**
- **pyright** - Python with type checking and analysis
- **gopls** - Go with staticcheck, gofumpt, comprehensive hints
- **jdtls** - Java development

#### **Scripting & Configuration**
- **lua_ls** - Lua with Neovim API completion and inlay hints
- **bashls** - Bash/Shell scripting
- **jsonls** - JSON with schema validation
- **yamlls** - YAML with schema support

#### **Templating**
- **jinja_lsp** - Jinja2 template support

### Features per Language

✅ **All languages get:**
- Auto-completion with snippets
- Go to definition/references/implementation
- Hover documentation
- Rename refactoring
- Code actions
- Diagnostics with virtual text
- Document symbols navigation

✅ **Enhanced features (where supported):**
- Inlay hints (types, parameters, return values)
- Semantic highlighting
- Code lens actions
- Call hierarchy
- Signature help in real-time

### Installation

All servers auto-install via Mason when you open a file of that type. Manual installation:

```vim
:Mason
" Select server and press 'i' to install
```

---

## ⚡ Performance Optimizations

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
- **Codelens auto-refresh** - Only on meaningful events
- **Semantic tokens** - Enabled selectively for better highlighting
- **Max file length limits** - Skip gitsigns/diagnostics on huge files (10k+ lines)

### Memory Efficiency
- **No AI models loaded** - No copilot, no codeium, no LLM overhead
- **Single colorscheme** - No multiple theme files loaded
- **Cleanup on buffer close** - Proper resource management
- **Optimized treesitter** - Only installed languages parsed

---

## 🚫 What's NOT Included (By Design)

This configuration intentionally excludes certain features to maintain its philosophy:

### ❌ AI Code Completion Tools
- **No GitHub Copilot** - Unpredictable suggestions, privacy concerns, learning impediment
- **No Codeium/TabNine/etc.** - Black box completions, requires internet, trust issues
- **Why?** - Traditional LSP provides predictable, context-aware completions based on actual code analysis. You learn by understanding your codebase, not by accepting mystery suggestions.

### ❌ Complex Debugging GUIs
- **No nvim-dap UI** - Terminal debugging is sufficient for most use cases
- **Why?** - Adds complexity and keybindings. Print debugging and LSP are enough for 95% of debugging tasks.

### ❌ Multiple Colorschemes
- **Only Catppuccin** - One well-configured theme
- **Why?** - Theme switching adds cognitive overhead and testing complexity. Pick one, configure it perfectly, move on.

### ❌ Git GUI Plugins
- **No lazygit.nvim/neogit** - gitsigns + terminal git is enough
- **Why?** - Learning git CLI is more valuable. Heavy git plugins add dependencies and startup time.

### ❌ Dashboard/Start Screens
- **No alpha/dashboard** - Opens to files immediately
- **Why?** - You're here to code, not admire ASCII art. Faster startup, clearer purpose.

### ❌ Session Management
- **No auto-session/persistence** - Manual session control via `:mksession`
- **Why?** - Automatic session restore can be confusing. Explicit is better than implicit.

### ❌ Every Possible LSP Server
- **Install what you need** - Via `:Mason` when needed
- **Why?** - Not every developer needs every language. On-demand installation keeps things lean.

### ❌ Test Runners/DAP
- **Use terminal commands** - `pytest`, `cargo test`, `go test`, etc.
- **Why?** - Language-specific test runners are better learned in their native environment.

### What You Get Instead

✅ **Speed** - No bloat means faster everything  
✅ **Predictability** - No surprises, no mysteries  
✅ **Learning** - Forces you to understand your tools  
✅ **Reliability** - Fewer dependencies, fewer breakages  
✅ **Focus** - Purpose-built for efficient coding  

---

## 🔧 Customization

### Adding Language Servers

Edit `lua/plugins/mason_lspconfig_config.lua`:
```lua
opts = {
  ensure_installed = {
    "lua_ls",
    "pyright", 
    "your_language_server", -- Add here
  },
}
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

## 🐛 Troubleshooting

### Common Issues

1. **Slow startup** - Run `:Lazy profile` to identify problematic plugins
2. **LSP not working** - Check `:Mason` for server installation status
3. **Telescope errors** - Ensure `ripgrep` and `fd` are installed
4. **Missing icons** - Install a Nerd Font and set it in your terminal

### Health Checks

```vim
:checkhealth          " General Neovim health
:checkhealth telescope " Telescope-specific health
:checkhealth mason     " Mason-specific health
```

## 📜 License

MIT License - Feel free to fork and customize for your needs!

## 🙏 Acknowledgments

This configuration is built on the shoulders of giants:

### Inspiration & Learning
- The Neovim community for incredible plugin ecosystem
- [ThePrimeagen](https://github.com/ThePrimeagen) for emphasizing speed and keyboard efficiency
- [TJ DeVries](https://github.com/tjdevries) for advancing Neovim and Telescope
- [Folke Lemaitre](https://github.com/folke) for revolutionary plugins (lazy.nvim, which-key, noice)

### Special Thanks
- All plugin authors who maintain these incredible tools
- The Neovim core team for the best editor ever created
- The Lua community for making Neovim configuration elegant
- Everyone who values performance and intentional design

### Built For
Developers who want to:
- Master their tools instead of being mastered by them
- Code faster by removing friction
- Learn deeply by understanding what they use
- Build a sustainable, long-term development environment

---

**"Perfection is achieved not when there is nothing more to add, but when there is nothing left to take away."**

*Happy Coding! 🚀*

</div>