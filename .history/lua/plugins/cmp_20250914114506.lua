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
    "onsails/lspkind.nvim",
    "zbirenbaum/copilot-cmp",
    "hrsh7th/cmp-nvim-lsp-signature-help",
  },
  config = function()
    local cmp_status, cmp = pcall(require, "cmp")
    if not cmp_status then
      return
    end

    local luasnip_status, luasnip = pcall(require, "luasnip")
    if not luasnip_status then
      return
    end

    local lspkind_status, lspkind = pcall(require, "lspkind")
    if not lspkind_status then
      return
    end

    -- Load VSCode-style snippets
    require("luasnip.loaders.from_vscode").lazy_load()

    -- Setup completion options
    vim.opt.completeopt = { "menu", "menuone", "noselect" }

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        }),
        
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expandable() then
            luasnip.expand()
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
      }),

      formatting = {
        format = lspkind.cmp_format({
          mode = "symbol_text",
          maxwidth = 50,
          ellipsis_char = "...",
          show_labelDetails = true,
          symbol_map = {
            Copilot = "",
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
          },
        }),
      },

      sources = cmp.config.sources({
        { name = "copilot", priority = 1000 },
        { name = "nvim_lsp", priority = 900 },
        { name = "luasnip", priority = 800 },
        { name = "nvim_lsp_signature_help", priority = 700 },
        { name = "nvim_lua", priority = 600 },
        { name = "path", priority = 500 },
        { name = "buffer", priority = 400, keyword_length = 3 },
      }),

      window = {
        completion = cmp.config.window.bordered({
          border = "rounded",
          winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
        }),
        documentation = cmp.config.window.bordered({
          border = "rounded",
          winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
        }),
      },

      experimental = {
        ghost_text = {
          hl_group = "CmpGhostText",
        },
      },
    })

    -- Command-line completion for search
    cmp.setup.cmdline("/", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" }
      },
    })

    -- Command-line completion for commands
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" }
      }, {
        { name = "cmdline", option = { ignore_cmds = { "Man", "!" } } }
      }),
    })
  end,
}
