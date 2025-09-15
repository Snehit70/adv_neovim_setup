return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  event = "VeryLazy",
  config = function()
    -- Custom components for useful info
    local function lsp_status()
      -- local clients = vim.lsp.get_active_clients({ bufnr = 0 })  this is depricated
      
      local clients = vim.lsp.get_clients({ bufnr = 0 })
      if #clients == 0 then
        return ""
      end
      local client_names = {}
      for _, client in ipairs(clients) do
        table.insert(client_names, client.name)
      end
      return " " .. table.concat(client_names, ", ")
    end

    local function search_count()
      if vim.v.hlsearch == 0 then
        return ""
      end
      local ok, result = pcall(vim.fn.searchcount, { maxcount = 999, timeout = 500 })
      if not ok or result.incomplete == 1 or result.total == 0 then
        return ""
      end
      return string.format(" %d/%d", result.current, result.total)
    end

    local function file_size()
      local size = vim.fn.getfsize(vim.fn.expand('%'))
      if size < 0 then return "" end
      if size < 1024 then return size .. "B" end
      if size < 1024 * 1024 then return string.format("%.1fK", size / 1024) end
      return string.format("%.1fM", size / (1024 * 1024))
    end

    require('lualine').setup {
      options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '│', right = '│' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
          statusline = { 'alpha', 'neo-tree', 'lazy', 'Trouble' },
          winbar = {},
        },
        globalstatus = true,
        always_divide_middle = true,
        
        -- Optimized refresh settings for performance
        refresh = {
          statusline = 250,  -- 4 FPS instead of 60 FPS
          tabline = 1000,    -- 1 FPS for tabline
          winbar = 1000,     -- 1 FPS for winbar
          -- Remove cursor movement events for better performance
          events = {
            'WinEnter',
            'BufEnter',
            'BufWritePost',
            'FileChangedShellPost',
            'VimResized',
            'ModeChanged',
          },
        },
      },
      
      sections = {
        -- Left side: Mode + Git info
        lualine_a = { 
          {
            'mode',
            fmt = function(str) 
              return str:sub(1,1) -- Just show first letter (N, I, V, etc.)
            end
          }
        },
        lualine_b = { 
          'branch',
          {
            'diff',
            symbols = { added = ' ', modified = ' ', removed = ' ' }
          }
        },
        
        -- Center: File info
        lualine_c = { 
          {
            'filename',
            path = 1, -- Show relative path
            symbols = {
              modified = ' ●',
              readonly = ' ',
              unnamed = '[No Name]',
            }
          },
          {
            file_size,
            color = { fg = '#6c7086' }, -- Subtle color
          }
        },
        
        -- Right side: Useful info
        lualine_x = { 
          {
            search_count,
            color = { fg = '#f9e2af' }, -- Highlight search
          },
          {
            'diagnostics',
            sources = { 'nvim_lsp' },
            symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
            colored = true,
            update_in_insert = false,
          },
          {
            lsp_status,
            color = { fg = '#94e2d5' }, -- LSP color
          }
        },
        lualine_y = { 'filetype' }, -- Just filetype, no encoding/format
        lualine_z = { 
          {
            'location',
            fmt = function(str)
              return str .. " 󰞇 %p%%"  -- Add percentage
            end
          }
        },
      },
      
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 
          {
            'filename',
            path = 1,
            color = { fg = '#6c7086' }, -- Dimmed for inactive
          }
        },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
      },
      
      extensions = { 'neo-tree', 'toggleterm', 'lazy' },
    }
  end
}
