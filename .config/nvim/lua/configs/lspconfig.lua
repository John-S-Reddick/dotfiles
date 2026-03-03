require("nvchad.configs.lspconfig").defaults()

local servers = {
    "html", "cssls", "gopls", "lua_ls","jedi_language_server"
}
--vim.lsp.config("gopls", {
--  cmd = { "~/go/bin/gopls", "serve" },
--})

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      -- diagnostics = {
      --   globals = { "vim" },
      -- },
      workspace = {
        library = {
          vim.fn.expand "$VIMRUNTIME/lua",
          vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types",
          vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
          "${3rd}/luv/library",
        },
        -- maxPreload = 100000,
        -- preloadFileSize = 10000,
      },
    },
  },
})

vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers 
