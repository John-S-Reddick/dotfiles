vim.opt.spelllang = 'en_us'
vim.opt.spell = true
return {
    {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  { "akinsho/toggleterm.nvim", opts = {}, cmd = { "ToggleTerm", "TermExec" } },
  { "cshuaimin/ssr.nvim", lazy = true },
  {
    "kdheepak/lazygit.nvim",
    cmd = "LazyGit",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("telescope").load_extension "lazygit"
    end,
  },
  {
  "lervag/vimtex",
  lazy = false,     -- we don't want to lazy load VimTeX
  -- tag = "v2.15", -- uncomment to pin to a specific release
  init = function()
    -- VimTeX configuration goes here, e.g.
    vim.g.vimtex_view_method = "zathura"
    vim.g.tex_flavor='latex'
    vim.g.vimtex_view_method='zathura'
    vim.g.tex_conceal='abdmg'
  end
  },
  {
    "ThePrimeagen/harpoon",
     dependencies = { "nvim-lua/plenary.nvim" }
  },
   -- test new blink
   { import = "nvchad.blink.lazyspec" },

   {
   	"nvim-treesitter/nvim-treesitter",
   	opts = {
   		ensure_installed = {
   			"vim", "lua", "vimdoc",
        "html", "css"
   		},
   	},
   },
}
