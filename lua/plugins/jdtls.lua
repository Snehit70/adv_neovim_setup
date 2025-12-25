-- Java LSP via nvim-jdtls (Gradle-first setup)
-- The actual jdtls setup is in ftplugin/java.lua to ensure it only runs for Java files
return {
  "mfussenegger/nvim-jdtls",
  ft = "java", -- Only load for Java files
  dependencies = {
    "williamboman/mason.nvim",
  },
}
