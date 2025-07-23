return {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",       -- Lua Language Server
          "pyright",      -- Python
          "vtsls", -- Javascript And Typescript
        },
        automatic_installation = true,
      })
    end,
  },
}

