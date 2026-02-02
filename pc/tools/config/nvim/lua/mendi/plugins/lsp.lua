return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local lspconfig = require("lspconfig")
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- Lua (Neovim config)
    lspconfig.lua_ls.setup({
      capabilities = capabilities,
    })

    -- C / C++
    lspconfig.clangd.setup({
      capabilities = capabilities,
    })
  end,
}

