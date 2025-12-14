return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  event = {"VeryLazy", "BufReadPost"},
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
      local ok, result = pcall(vim.fn.searchcount, { maxcount = 999, timeout = 100 })
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

    -- Word count for markdown/text files
    local function word_count()
      local ft = vim.bo.filetype
      if ft == "markdown" or ft == "text" or ft == "org" then
        local words = vim.fn.wordcount().words
        return "󰆙 " .. words
      end
      return ""
    end

    -- Indentation display
    local function indent_info()
      if vim.bo.expandtab then
        return "␣ " .. vim.bo.shiftwidth
      else
        return "⇥ " .. vim.bo.tabstop
      end
    end

    -- Recording macro indicator
    local function recording_macro()
      local reg = vim.fn.reg_recording()
      if reg == "" then return "" end
      return " @" .. reg
    end

    -- Lazy.nvim updates available
    local function lazy_updates()
      local ok, lazy = pcall(require, "lazy.status")
      if ok and lazy.has_updates() then
        return " " .. lazy.updates()
      end
      return ""
    end

    -- DAP debugging status
    local function dap_status()
      local ok, dap = pcall(require, "dap")
      if not ok then return "" end
      local session = dap.session()
      if session then
        return " " .. session.config.type
      end
      return ""
    end

    -- Show encoding only if not UTF-8
    local function file_encoding()
      local encoding = vim.opt.fileencoding:get()
      if encoding == "" or encoding == "utf-8" then
        return ""
      end
      return encoding:upper()
    end

    -- Show format only if not unix
    local function file_format()
      local format = vim.bo.fileformat
      if format == "unix" then
        return ""
      end
      local icons = { unix = "", dos = "", mac = "" }
      return icons[format] or format
    end

    -- Session info
    local function session_info()
      -- Check if auto-session or persistence.nvim is loaded
      local ok, _ = pcall(require, "auto-session")
      if ok and vim.g.persisting then
        return " "
      end
      return ""
    end

    -- Python virtual environment
    local function python_env()
      if vim.bo.filetype ~= "python" then return "" end
      local venv = os.getenv("VIRTUAL_ENV")
      if venv then
        return " " .. vim.fn.fnamemodify(venv, ":t")
      end
      return ""
    end

    -- Buffer count
    local function buffer_count()
      local buffers = vim.fn.len(vim.fn.getbufinfo({buflisted = 1}))
      return " " .. buffers
    end

    -- Dynamic color helpers (use theme colors or fallback to hex)
    local function get_color(group, attr)
      local hl = vim.api.nvim_get_hl(0, { name = group })
      if hl and hl[attr] then
        return string.format("#%06x", hl[attr])
      end
      return nil
    end

    require('lualine').setup {
      options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
          statusline = { 'alpha', 'neo-tree', 'lazy', 'Trouble', 'dashboard', 'starter' },
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
          },
          {
            recording_macro,
            color = { fg = get_color("ErrorMsg", "fg") or "#ff5555", gui = "bold" },
          }
        },
        lualine_b = { 
          {
            'branch',
            icon = '',
          },
          {
            'diff',
            symbols = { added = ' ', modified = ' ', removed = ' ' },
            diff_color = {
              added = { fg = get_color("GitSignsAdd", "fg") or "#a6e3a1" },
              modified = { fg = get_color("GitSignsChange", "fg") or "#f9e2af" },
              removed = { fg = get_color("GitSignsDelete", "fg") or "#f38ba8" },
            },
          },
          {
            session_info,
            color = { fg = get_color("String", "fg") or "#94e2d5" },
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
            color = { fg = get_color("Comment", "fg") or "#6c7086" },
          },
          {
            word_count,
            color = { fg = get_color("Special", "fg") or "#cba6f7" },
          },
          {
            python_env,
            color = { fg = get_color("Function", "fg") or "#89b4fa" },
          }
        },
        
        -- Right side: Useful info
        lualine_x = { 
          {
            lazy_updates,
            color = { fg = get_color("DiagnosticWarn", "fg") or "#fab387" },
          },
          {
            dap_status,
            color = { fg = get_color("DiagnosticError", "fg") or "#f38ba8" },
          },
          {
            search_count,
            color = { fg = get_color("WarningMsg", "fg") or "#f9e2af" },
          },
          {
            'diagnostics',
            sources = { 'nvim_lsp' },
            symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
            colored = true,
            update_in_insert = false,
            diagnostics_color = {
              error = { fg = get_color("DiagnosticError", "fg") or "#f38ba8" },
              warn = { fg = get_color("DiagnosticWarn", "fg") or "#fab387" },
              info = { fg = get_color("DiagnosticInfo", "fg") or "#89dceb" },
              hint = { fg = get_color("DiagnosticHint", "fg") or "#94e2d5" },
            },
          },
          {
            lsp_status,
            color = { fg = get_color("Function", "fg") or "#94e2d5" },
          }
        },
        lualine_y = { 
          {
            buffer_count,
            color = { fg = get_color("Type", "fg") or "#cba6f7" },
          },
          {
            indent_info,
            color = { fg = get_color("Comment", "fg") or "#6c7086" },
          },
          {
            file_encoding,
            color = { fg = get_color("Comment", "fg") or "#6c7086" },
          },
          {
            file_format,
            color = { fg = get_color("Comment", "fg") or "#6c7086" },
          },
          'filetype',
        },
        lualine_z = { 
          {
            'progress',
            fmt = function(str)
              return str .. " "
            end
          },
          'location',
        },
      },
      
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 
          {
            'filename',
            path = 1,
            color = { fg = get_color("Comment", "fg") or "#6c7086" },
          }
        },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
      },
      
      extensions = { 'neo-tree', 'toggleterm', 'lazy', 'mason', 'quickfix' },
    }
  end
}
