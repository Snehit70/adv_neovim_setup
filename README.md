# Neovim Configuration

<div align="center">

<https://github.com/snehitg/nvim/assets/83359593/a83368b3-308c-4431-8a8a-8d3a586a13a5>

</div>

This is a detailed guide to a Neovim setup tailored for modern development, with a focus on performance, aesthetics, and robust features. This configuration is built around `lazy.nvim` for plugin management and includes a curated set of plugins for everything from autocompletion and LSP integration to Git workflows and UI enhancements.

## Features

-   **Fast Startup Time:** Optimized with `lazy.nvim` to load plugins efficiently.
-   **Modern UI:** A clean and functional interface with `gruvbox`, `bufferline`, `lualine`, and `neo-tree`.
-   **Powerful Autocompletion:** `nvim-cmp` with a variety of sources, including LSP, snippets, and buffer text.
-   **Full LSP Support:** Integrated with `nvim-lspconfig` and `mason.nvim` for easy management of language servers.
-   **Git Integration:** Seamless Git workflow with `gitsigns` and `vim-fugitive`.
-   **Telescope:** For finding, filtering, and previewing anything.
-   **Treesitter:** For advanced syntax highlighting and code navigation.
-   **Formatting:** Automatic code formatting on save with `conform.nvim`.
-   **AI-Assisted Development:** Code with the help of `avante.nvim` and `copilot.lua`.

## Installation

1.  **Clone the repository:**

    ```bash
    git clone https://github.com/snehitg/nvim.git ~/.config/nvim
    ```

2.  **Install Neovim:** Make sure you have Neovim v0.8.0+ installed. You can find the installation instructions [here](https://github.com/neovim/neovim/wiki/Installing-Neovim).

3.  **Install Dependencies:**
    -   A [Nerd Font](https://www.nerdfonts.com/) (for icons)
    -   `ripgrep` (for Telescope live grep)
    -   `fd` (for Telescope file finding)
    -   `xclip` or `wl-copy` (for clipboard support)
    -   A C compiler for `nvim-treesitter`

4.  **Launch Neovim:** Open Neovim, and `lazy.nvim` will automatically install the plugins.

## Customization

You can customize this configuration by editing the files in the `lua/plugins` directory. Each file corresponds to a plugin and its configuration. For example, to change the colorscheme, you can edit the `lua/plugins/colorscheme.lua` file.

You can also add your own plugins by creating a new file in the `lua/plugins` directory. Make sure to follow the `lazy.nvim` plugin specification format.

## Plugins

| Plugin | Description |
| --- | --- |
| [`lazy.nvim`](https://github.com/folke/lazy.nvim) | Plugin manager |
| [`gruvbox.nvim`](https://github.com/ellisonleao/gruvbox.nvim) | Colorscheme |
| [`nvim-autopairs`](https://github.com/windwp/nvim-autopairs) | Autopairs for quotes, brackets, etc. |
| [`nvim-ts-autotag`](https://github.com/windwp/nvim-ts-autotag) | Automatically closes and renames HTML/XML tags |
| [`avante.nvim`](https://github.com/replete-repl/avante.nvim) | AI-powered code generation and editing |
| [`bufferline.nvim`](https://github.com/akinsho/bufferline.nvim) | A stylish tabline for buffers |
| [`nvim-cmp`](https://github.com/hrsh7th/nvim-cmp) | Autocompletion engine |
| [`Comment.nvim`](https://github.com/numToStr/Comment.nvim) | Smart commenting |
| [`conform.nvim`](https://github.com/stevearc/conform.nvim) | Code formatter |
| [`copilot.lua`](https://github.com/github/copilot.lua) | GitHub Copilot integration |
| [`vim-fugitive`](https://github.com/tpope/vim-fugitive) | Git wrapper |
| [`gitsigns.nvim`](https://github.com/lewis6991/gitsigns.nvim) | Git decorations in the sign column |
| [`indent-blankline.nvim`](https://github.com/lukas-reineke/indent-blankline.nvim) | Indentation guides |
| [`nvim-lspconfig`](https://github.com/neovim/nvim-lspconfig) | LSP configuration |
| [`lualine.nvim`](https://github.com/nvim-lualine/lualine.nvim) | Statusline |
| [`markdown-preview.nvim`](https://github.com/iamcco/markdown-preview.nvim) | Markdown preview in the browser |
| [`mason.nvim`](https://github.com/williamboman/mason.nvim) | Manages LSP servers, DAP servers, linters, and formatters |
| [`mason-lspconfig.nvim`](https://github.com/williamboman/mason-lspconfig.nvim) | Bridges `mason.nvim` and `nvim-lspconfig` |
| [`mini.surround`](https://github.com/echasnovski/mini.surround) | Surrounding text with pairs |
| [`neo-tree.nvim`](https://github.com/nvim-neo-tree/neo-tree.nvim) | File explorer |
| [`snacks.nvim`](https://github.com/mrded/snacks.nvim) | UI enhancements for notifications, status column, and more |
| [`telescope.nvim`](https://github.com/nvim-telescope/telescope.nvim) | Fuzzy finder |
| [`toggleterm.nvim`](https://github.com/akinsho/toggleterm.nvim) | Manages terminal windows |
| [`nvim-treesitter`](https://github.com/nvim-treesitter/nvim-treesitter) | Advanced syntax highlighting and code navigation |
| [`which-key.nvim`](https://github.com/folke/which-key.nvim) | Shows a popup with keybindings |

## Keybindings

### Leader Key: `<Space>`

#### General

| Keybinding | Description |
| --- | --- |
| `<leader>e` | Toggle file explorer |
| `<leader>tt` | Toggle floating terminal |
| `<leader>th` | Toggle horizontal terminal |
| `<leader>cf` | Format code |
| `<leader>mp` | Toggle Markdown preview |

#### Telescope

| Keybinding | Description |
| --- | --- |
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fb` | Find buffers |
| `<leader>fh` | Find help tags |

#### LSP

| Keybinding | Description |
| --- | --- |
| `<leader>ca` | Code actions |
| `<leader>d` | Line diagnostics |
| `<leader>q` | Diagnostics list |
| `<leader>rn` | Rename symbol |

#### Git

| Keybinding | Description |
| --- | --- |
| `<leader>gG` | Git status |
| `<leader>gc` | Git commit |
| `<leader>gL` | Git log (oneline) |
| `<leader>gl` | Git log (full) |
| `<leader>gh` | File history |
| `<leader>gD` | Diff with HEAD |
| `<leader>gm` | Mergetool |
| `<leader>gp` | Git push |
| `<leader>gP` | Git pull |
| `<leader>gb` | Git branches |
| `<leader>gs` | Stage hunk |
| `<leader>gr` | Reset hunk |
| `<leader>gS` | Stage buffer |
| `<leader>gR` | Reset buffer |
| `<leader>gph`| Preview hunk |
| `<leader>gbl`| Blame line |
| `<leader>gt` | Toggle line blame |

#### AI (Avante)

| Keybinding | Description |
| --- | --- |
| `<leader>aa` | Avante: Ask |
| `<leader>ar` | Avante: Refresh |
| `<leader>ae` | Avante: Edit |
| `<leader>at` | Avante: Toggle |
| `<leader>af` | Avante: Focus |
| `<leader>ac` | Avante: Chat |

### Other Mappings

| Keybinding | Description |
| --- | --- |
| `gd` | Go to definition |
| `K` | Hover documentation |
| `gi` | Go to implementation |
| `gr` | Find references |
| `[d` | Previous diagnostic |
| `]d` | Next diagnostic |
| `ys` | Add surrounding |
| `ds` | Delete surrounding |
| `cs` | Change surrounding |

## LSP and Formatting

This configuration uses `mason.nvim` to manage LSP servers and formatters. The following are configured:

-   **LSP Servers:**
    -   `lua_ls`
    -   `pyright`
    -   `ts_ls`
    -   `html`
    -   `cssls`
    -   `bashls`
    -   `jsonls`
    -   `emmet_ls`
    -   `jinja_lsp`
-   **Formatters:**
    -   `black` (Python)
    -   `prettier` (JavaScript, TypeScript, HTML, CSS, JSON, YAML)
    -   `stylua` (Lua)
    -   `shfmt` (Shell)
    -   `djlint` (Jinja, HTML Django)

Formatting is automatically applied on save. You can also manually format the code with `<leader>cf`.