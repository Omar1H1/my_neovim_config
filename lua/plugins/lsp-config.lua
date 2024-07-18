return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          "java-debug-adapter",
          "java-test",
        },
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local on_attach = function(client, bufnr)
        -- Keybindings for LSP
        vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "LSP Hover" })
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to Definition" })
        vim.keymap.set(
          { "n", "v" },
          "<leader>ca",
          vim.lsp.buf.code_action,
          { buffer = bufnr, desc = "Code Action" }
        )
      end

      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "jdtls", "tsserver" },
        automatic_installation = true,
        setup_handlers = {
          function(server_name)
            if server_name == "jdtls" then
              lspconfig[server_name].setup({
                on_attach = on_attach,
                capabilities = capabilities,
              })
              return
            end
            lspconfig[server_name].setup({
              capabilities = capabilities,
              on_attach = on_attach,
            })
          end,
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local on_attach = function(client, bufnr)
        -- Keybindings for LSP
        vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "LSP Hover" })
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to Definition" })
        vim.keymap.set(
          { "n", "v" },
          "<leader>ca",
          vim.lsp.buf.code_action,
          { buffer = bufnr, desc = "Code Action" }
        )
      end

      lspconfig.lua_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })
      lspconfig.tsserver.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })
    end,
  },
}
