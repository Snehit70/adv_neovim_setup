-- ftplugin/java.lua
-- Automatically starts nvim-jdtls for Java files with Gradle-first root detection

-- Prevent loading twice
if vim.b.jdtls_setup_done then
  return
end
vim.b.jdtls_setup_done = true

-- Only proceed if nvim-jdtls is available
local jdtls_ok, jdtls = pcall(require, "jdtls")
if not jdtls_ok then
  return
end

-- Find project root with Gradle priority
local root_markers = {
  -- Gradle (priority)
  "gradlew",
  "build.gradle",
  "build.gradle.kts",
  "settings.gradle",
  "settings.gradle.kts",
  -- Maven fallback
  "pom.xml",
  -- Generic
  ".git",
}

local root_dir = vim.fs.root(0, root_markers) or vim.fn.getcwd()

-- Project name for workspace
local project_name = vim.fn.fnamemodify(root_dir, ":p:t")

-- Workspace directory (persistent per-project)
local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. project_name

-- Ensure workspace directory exists
vim.fn.mkdir(workspace_dir, "p")

-- Find jdtls installation (Mason or system)
local function get_jdtls_paths()
  local jdtls_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
  local jar = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
  if jar ~= "" then
    return {
      jar = jar,
      config = jdtls_path .. "/config_linux", -- Adjust for macOS: config_mac
    }
  end
  return nil
end

local jdtls_paths = get_jdtls_paths()

-- Build command
local cmd = {}
if jdtls_paths and jdtls_paths.jar ~= "" then
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xmx2g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens", "java.base/java.util=ALL-UNNAMED",
    "--add-opens", "java.base/java.lang=ALL-UNNAMED",
    "-jar", jdtls_paths.jar,
    "-configuration", jdtls_paths.config,
    "-data", workspace_dir,
  }
else
  -- Fallback: use jdtls wrapper script if available
  cmd = { "jdtls", "-data", workspace_dir }
end

-- Capabilities (integrate with nvim-cmp if available)
local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
if cmp_ok then
  capabilities = cmp_lsp.default_capabilities(capabilities)
end

-- On attach function
local on_attach = function(client, bufnr)
  local map = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
  end

  -- Standard LSP keymaps
  map("n", "<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
  map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Actions")
  map("n", "<leader>cf", function()
    local conform_ok, conform = pcall(require, "conform")
    if conform_ok then
      conform.format({ async = true, lsp_fallback = true })
    else
      vim.lsp.buf.format({ async = true })
    end
  end, "Format Code")
  map("n", "<leader>d", vim.diagnostic.open_float, "Show Line Diagnostics")
  map("n", "[d", vim.diagnostic.goto_prev, "Previous Diagnostic")
  map("n", "]d", vim.diagnostic.goto_next, "Next Diagnostic")

  -- Java-specific keymaps (nvim-jdtls extras)
  map("n", "<leader>jo", jdtls.organize_imports, "Organize Imports")
  map("n", "<leader>jv", jdtls.extract_variable, "Extract Variable")
  map("v", "<leader>jv", function() jdtls.extract_variable(true) end, "Extract Variable")
  map("n", "<leader>jc", jdtls.extract_constant, "Extract Constant")
  map("v", "<leader>jc", function() jdtls.extract_constant(true) end, "Extract Constant")
  map("v", "<leader>jm", function() jdtls.extract_method(true) end, "Extract Method")

  -- Inlay hints toggle (if supported)
  if client.server_capabilities.inlayHintProvider then
    map("n", "<leader>th", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
    end, "Toggle Inlay Hints")
  end
end

-- Configuration
local config = {
  cmd = cmd,
  root_dir = root_dir,
  capabilities = capabilities,
  on_attach = on_attach,

  settings = {
    java = {
      signatureHelp = { enabled = true },
      contentProvider = { preferred = "fernflower" },
      completion = {
        favoriteStaticMembers = {
          "org.junit.Assert.*",
          "org.junit.jupiter.api.Assertions.*",
          "org.mockito.Mockito.*",
          "java.util.Objects.requireNonNull",
          "java.util.Objects.requireNonNullElse",
        },
        filteredTypes = {
          "com.sun.*",
          "io.micrometer.shaded.*",
          "java.awt.*",
          "jdk.*",
          "sun.*",
        },
      },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
      codeGeneration = {
        toString = {
          template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
        },
        useBlocks = true,
      },
      configuration = {
        -- If you have specific JDK paths, configure them here
        -- runtimes = {
        --   { name = "JavaSE-17", path = "/path/to/jdk-17" },
        --   { name = "JavaSE-21", path = "/path/to/jdk-21" },
        -- },
      },
    },
  },

  -- Needed for auto-completion with method signatures and placeholders
  init_options = {
    bundles = {},
  },
}

-- Start or attach jdtls
jdtls.start_or_attach(config)
