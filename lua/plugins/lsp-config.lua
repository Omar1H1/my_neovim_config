return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {"lua_ls", "tsserver"}
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")

      -- Ensure the language server is installed by Mason
      local mason_registry = require("mason-registry")
      if not mason_registry.is_installed("lua-language-server") then
        print("Installing lua-language-server...")
        mason_registry.get_package("lua-language-server"):install()
      end

      lspconfig.lua_ls.setup({})
      lspconfig.tsserver.setup({})

      -- Ensure LSP is loaded before setting key mappings
      if vim.lsp and vim.lsp.buf then
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "LSP Hover" })
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Go to Definition" })
        vim.keymap.set({'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action, { desc = "Code Action" })
      else
        print("LSP not loaded, key mappings not set")
      end
    end
  }
}

