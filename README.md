# 🚀 Advanced Neovim Configuration

<div align="center">

![Neovim](https://img.shields.io/badge/NeoVim-%2357A143.svg?&style=for-the-badge&logo=neovim&logoColor=white)
![Lua](https://img.shields.io/badge/lua-%232C2D72.svg?style=for-the-badge&logo=lua&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)

**A blazing fast, minimal yet powerful Neovim setup optimized for productivity**

</div>

## ✨ Features

- 🚀 **Lightning Fast Startup** - Optimized with `lazy.nvim` and performance-first configurations
- 🎨 **Modern UI** - Clean interface with `catppuccin`, optimized `bufferline`, and minimal `lualine`
- 🔍 **Powerful Search** - Enhanced `telescope` with comprehensive ignore patterns and optimizations
- ⚡ **Smart Autocompletion** - `nvim-cmp` with prioritized sources and **NO AI completions** for predictable results
- 🔧 **Robust LSP** - Full language server integration with `mason.nvim` and error handling
- 📁 **Floating File Explorer** - `neo-tree` with comprehensive ignore patterns and vim-like navigation
- 💻 **Integrated Terminal** - Floating terminal with `toggleterm` for quick command execution
- 🎯 **Floating Command Line** - `noice.nvim` for sleek command input experience
- 📝 **LeetCode Integration** - Built-in coding practice environment

## 🛠️ Philosophy

This configuration prioritizes:
- **Speed over features** - Only essential functionality, highly optimized
- **Predictability over AI** - Traditional LSP-based completions, no AI interference  
- **Keyboard-first workflow** - Minimal mouse dependency, vim-like navigation
- **Floating UI** - Modern popup-based interface for better focus

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
| `<leader>fr` | Config Files | Quick access to Neovim config |

#### 📁 **File Explorer (Neo-tree)**
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>e` | Toggle Explorer | Open/close floating file tree |
| `<leader>E` | Focus Explorer | Focus on open file tree |

#### 💻 **Terminal**
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>tt` | Toggle Terminal | Floating terminal for commands |

#### 🔧 **LSP & Code**
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>ca` | Code Actions | Show available fixes/refactors |
| `<leader>rn` | Rename Symbol | Rename across entire project |
| `<leader>cf` | Format Code | Format current buffer |
| `<leader>d` | Show Diagnostics | Error details in popup |
| `<leader>q` | Diagnostics List | All errors/warnings in quickfix |

#### 📚 **LeetCode**
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>lq` | LeetCode Menu | Open problem browser |
| `<leader>ll` | List Problems | Browse available problems |
| `<leader>lt` | Test Solution | Run test cases |
| `<leader>ls` | Submit Solution | Submit to LeetCode |
| `<leader>lr` | Run Solution | Execute with custom input |

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

## 🔌 Plugin Ecosystem

### Core Framework
- **[lazy.nvim](https://github.com/folke/lazy.nvim)** - Ultra-fast plugin manager
- **[plenary.nvim](https://github.com/nvim-lua/plenary.nvim)** - Essential Lua utilities

### User Interface  
- **[catppuccin](https://github.com/catppuccin/nvim)** - Beautiful colorscheme with integrations
- **[lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)** - Optimized statusline with useful info
- **[bufferline.nvim](https://github.com/akinsho/bufferline.nvim)** - Clean buffer tabs with management
- **[noice.nvim](https://github.com/folke/noice.nvim)** - Floating command line and messages
- **[indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)** - Indentation guides

### File Management
- **[neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim)** - Floating file explorer with git integration
- **[telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)** - Fuzzy finder with performance optimizations

### Code Intelligence
- **[nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)** - LSP configuration with error handling
- **[mason.nvim](https://github.com/williamboman/mason.nvim)** - LSP server management
- **[nvim-cmp](https://github.com/hrsh7th/nvim-cmp)** - Completion engine (NO AI - traditional LSP only)
- **[nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)** - Advanced syntax highlighting

### Development Tools
- **[gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)** - Git decorations and hunk management
- **[Comment.nvim](https://github.com/numToStr/Comment.nvim)** - Smart commenting with treesitter
- **[nvim-autopairs](https://github.com/windwp/nvim-autopairs)** - Auto-close brackets and quotes
- **[toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim)** - Floating terminal integration
- **[which-key.nvim](https://github.com/folke/which-key.nvim)** - Keybinding hints and documentation

### Language Support
- **[nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag)** - HTML/XML tag completion
- **[markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim)** - Live markdown preview

### Specialized Tools
- **[leetcode.nvim](https://github.com/kawre/leetcode.nvim)** - Integrated coding practice environment

## 🎯 Language Server Configuration

### Automatically Managed LSP Servers
- **lua_ls** - Lua language server with Neovim API support
- **pyright** - Python static type checker and language server  
- **ts_ls** - TypeScript/JavaScript language server
- **html** - HTML language server
- **cssls** - CSS language server
- **bashls** - Bash language server
- **jsonls** - JSON language server
- **emmet_ls** - Emmet abbreviation support
- **jinja_lsp** - Jinja template support

All servers are automatically installed and updated via Mason.

## ⚡ Performance Optimizations

- **Lazy loading** - Plugins load only when needed
- **Optimized refresh rates** - Statusline updates at 4 FPS instead of 60 FPS
- **Smart ignore patterns** - Comprehensive file filtering for faster searches
- **Debounced operations** - Reduced unnecessary updates
- **Error handling** - Graceful fallbacks prevent crashes
- **Minimal dependencies** - Only essential plugins included

## 🚫 What's NOT Included

This configuration intentionally excludes:
- **AI completions** (Copilot, CodeiumKw, etc.) - for predictable, traditional LSP-based suggestions
- **Complex formatting tools** - relies on LSP formatting capabilities
- **Heavy git plugins** - uses lightweight gitsigns for essential git integration
- **Multiple colorschemes** - focuses on one well-configured theme
- **Excessive keybindings** - minimal, conflict-free keymap set

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

Built with inspiration from the Neovim community and optimized for real-world development workflows.