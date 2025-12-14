return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-buffer", 
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "saadparwaiz1/cmp_luasnip",
    "L3MON4D3/LuaSnip",
    "rafamadriz/friendly-snippets",
    -- NOTE: NO AI completions - VSCode-like traditional completions only
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    
    require("luasnip.loaders.from_vscode").lazy_load()
    
    -- Load custom C++ snippets
    luasnip.add_snippets("cpp", require("snippets.cpp"))
    
    vim.opt.completeopt = { "menu", "menuone", "noselect" }
    vim.opt.pumheight = 12 -- VSCode-like height

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      -- VSCode-like keybindings - Enter WORKS!
      mapping = {
        -- ENTER accepts the highlighted suggestion (like VSCode)
        ["<CR>"] = cmp.mapping.confirm({ 
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,  -- Only confirm explicitly selected items
        }),
        
        -- Tab cycles through suggestions (VSCode behavior)
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
        
        -- Additional snippet navigation
        ["<C-l>"] = cmp.mapping(function()
          if luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          end
        end, { "i", "s" }),
        
        ["<C-h>"] = cmp.mapping(function()
          if luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          end
        end, { "i", "s" }),
        
        -- Ctrl+Space triggers completion (VSCode default)
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        
        -- Arrow keys work like VSCode
        ["<Down>"] = cmp.mapping.select_next_item(),
        ["<Up>"] = cmp.mapping.select_prev_item(),
      },

      -- VSCode-like completion priority order
      sources = cmp.config.sources({
        -- EXACT VSCode order: IntelliSense first, then others
        { 
          name = "nvim_lsp", 
          priority = 1000,
          keyword_length = 1,
          max_item_count = 20,
        },
        { 
          name = "nvim_lua", 
          priority = 900,
          keyword_length = 1, 
          max_item_count = 15,
        },
        { 
          name = "path", 
          priority = 800,
          keyword_length = 2,
          max_item_count = 10,
        },
        { 
          name = "buffer", 
          priority = 700,
          keyword_length = 3,
          max_item_count = 8,
          option = {
            get_bufnrs = function()
              return { vim.api.nvim_get_current_buf() }
            end
          },
        },
        -- Snippets LAST (like VSCode User Snippets at bottom)
        { 
          name = "luasnip", 
          priority = 500,
          keyword_length = 2,
          max_item_count = 5,
        },
      }),

      -- Clean VSCode-like formatting
      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, item)
          -- LSP kind icons
          local kind_icons = {
            Text = "󰉿",
            Method = "󰆧",
            Function = "󰊕",
            Constructor = "",
            Field = "󰜢",
            Variable = "󰀫",
            Class = "󰠱",
            Interface = "",
            Module = "",
            Property = "󰜢",
            Unit = "󰑭",
            Value = "󰎠",
            Enum = "",
            Keyword = "󰌋",
            Snippet = "",
            Color = "󰏘",
            File = "󰈙",
            Reference = "󰈇",
            Folder = "󰉋",
            EnumMember = "",
            Constant = "󰏿",
            Struct = "󰙅",
            Event = "",
            Operator = "󰆕",
            TypeParameter = "",
          }
          
          -- VSCode-like source labels
          local menu_icons = {
            nvim_lsp = "[LSP]",
            nvim_lua = "[Lua]",
            buffer = "[Text]", 
            path = "[Path]",
            luasnip = "[Snip]",
          }
          
          -- Add kind icon
          item.kind = string.format('%s %s', kind_icons[item.kind] or "", item.kind)
          item.menu = menu_icons[entry.source.name] or ""
          
          -- Truncate long completions (VSCode behavior)
          if #item.abbr > 25 then
            item.abbr = string.sub(item.abbr, 1, 22) .. "..."
          end
          
          return item
        end,
      },

      -- Clean VSCode-like window
      window = {
        completion = cmp.config.window.bordered({
          border = "single",
          winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel",
        }),
        -- NO documentation window (you don't want it)
      },

      -- VSCode-like sorting: exact matches first, then fuzzy
      sorting = {
        comparators = {
          cmp.config.compare.exact,
          cmp.config.compare.score,
          cmp.config.compare.recently_used,
          cmp.config.compare.locality,
          cmp.config.compare.kind,
          cmp.config.compare.length,
          cmp.config.compare.order,
        },
      },

      -- Fast performance like VSCode
      performance = {
        max_view_entries = 15,
        debounce = 30,
        throttle = 10,
      },
    })

    -- Command line completion (minimal)
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "path", max_item_count = 10 },
        { name = "cmdline", max_item_count = 10 },
      },
    })
    
    -- Search completion
    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer", max_item_count = 10 },
      },
    })
  end,
}
