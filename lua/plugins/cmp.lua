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
    "hrsh7th/cmp-nvim-lsp-signature-help",
    -- NOTE: NO AI completions (Copilot, Codeium, etc.) will be used
    -- This setup focuses on traditional LSP-based completions for better control
  },
  config = function()
    -- Error handling for required dependencies
    local cmp_status, cmp = pcall(require, "cmp")
    if not cmp_status then
      vim.notify("nvim-cmp not found!", vim.log.levels.ERROR)
      return
    end

    local luasnip_status, luasnip = pcall(require, "luasnip")
    if not luasnip_status then
      vim.notify("LuaSnip not found!", vim.log.levels.ERROR)
      return
    end

    local lspkind_status, lspkind = pcall(require, "lspkind")
    if not lspkind_status then
      vim.notify("lspkind not found!", vim.log.levels.ERROR)
      return
    end

    -- Load VSCode-style snippets for better snippet support
    require("luasnip.loaders.from_vscode").lazy_load()

    -- Optimized completion options for speed
    vim.opt.completeopt = { "menu", "menuone", "noselect" }
    vim.opt.pumheight = 15 -- Limit popup menu height for performance

    cmp.setup({
      -- Performance settings
      performance = {
        debounce = 60,
        throttle = 30,
        fetching_timeout = 500,
        confirm_resolve_timeout = 80,
        async_budget = 1,
        max_view_entries = 200,
      },

      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      mapping = cmp.mapping.preset.insert({
        -- Documentation scrolling (faster)
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        
        -- Manual completion trigger
        ["<C-Space>"] = cmp.mapping.complete(),
        
        -- Abort completion
        ["<C-e>"] = cmp.mapping.abort(),
        
        -- Smart confirm - don't auto-select for accuracy
        ["<CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = false, -- Don't auto-select for better accuracy
        }),
        
        -- Enhanced Tab behavior with snippet support
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
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
            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),

        -- Quick navigation
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
      }),

      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = lspkind.cmp_format({
          mode = "symbol_text",
          maxwidth = 50,
          ellipsis_char = "...",
          show_labelDetails = true,
          before = function(entry, vim_item)
            -- Source indicators for better context
            local menu_icon = {
              nvim_lsp = "󰒋",
              luasnip = "󰩫",
              buffer = "󰈚",
              path = "󰉋",
              nvim_lua = "󰢱",
              nvim_lsp_signature_help = "󰊕",
            }
            vim_item.menu = (menu_icon[entry.source.name] or "󰠖") .. " " .. (entry.source.name or "")
            return vim_item
          end,
        }),
      },

      -- Optimized sources with priority for speed and accuracy
      sources = cmp.config.sources({
        {
          name = "nvim_lsp",
          priority = 1000,
          keyword_length = 1,
          max_item_count = 50,
          group_index = 1,
        },
        {
          name = "nvim_lsp_signature_help",
          priority = 900,
          keyword_length = 1,
          max_item_count = 20,
          group_index = 1,
        },
        {
          name = "luasnip",
          priority = 800,
          keyword_length = 2,
          max_item_count = 15,
          group_index = 1,
        },
        {
          name = "nvim_lua",
          priority = 700,
          keyword_length = 2,
          max_item_count = 30,
          group_index = 1,
        },
        {
          name = "path",
          priority = 600,
          keyword_length = 3,
          max_item_count = 20,
          group_index = 2,
        },
        {
          name = "buffer",
          priority = 500,
          keyword_length = 3,
          max_item_count = 15,
          group_index = 3,
          option = {
            get_bufnrs = function()
              local bufs = {}
              for _, win in ipairs(vim.api.nvim_list_wins()) do
                bufs[vim.api.nvim_win_get_buf(win)] = true
              end
              return vim.tbl_keys(bufs)
            end
          },
        },
      }),

      -- Enhanced UI for better visual feedback
      window = {
        completion = cmp.config.window.bordered({
          border = "rounded",
          winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
        }),
        documentation = cmp.config.window.bordered({
          border = "rounded",
          winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
          max_width = 80,
          max_height = 20,
        }),
      },

      -- Experimental features for better UX
      experimental = {
        ghost_text = {
          hl_group = "CmpGhostText",
        },
      },

      -- Sorting for better accuracy
      sorting = {
        priority_weight = 2,
        comparators = {
          cmp.config.compare.offset,
          cmp.config.compare.exact,
          cmp.config.compare.score,
          cmp.config.compare.recently_used,
          cmp.config.compare.locality,
          cmp.config.compare.kind,
          cmp.config.compare.sort_text,
          cmp.config.compare.length,
          cmp.config.compare.order,
        },
      },
    })

    -- Command-line completion for search (optimized)
    cmp.setup.cmdline("/", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer", max_item_count = 10 }
      },
      formatting = {
        fields = { "abbr" },
      },
    })

    -- Command-line completion for commands (optimized)
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path", max_item_count = 15 }
      }, {
        { 
          name = "cmdline", 
          max_item_count = 20,
          option = { 
            ignore_cmds = { "Man", "!" } 
          }
        }
      }),
      formatting = {
        fields = { "abbr" },
      },
    })

    -- Set up highlight groups for better visual feedback
    vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
    
    -- Performance optimization: disable cmp in large files
    vim.api.nvim_create_autocmd("BufReadPre", {
      callback = function()
        local file_size = vim.fn.getfsize(vim.fn.expand("%"))
        if file_size > 1024 * 1024 then -- 1MB
          vim.b.large_file = true
          require("cmp").setup.buffer({ enabled = false })
        end
      end,
    })
  end,
}
