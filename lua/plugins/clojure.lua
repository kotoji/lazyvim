return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "clojure" } },
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "clojure-lsp",
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clojure_lsp = {},
      },
    },
  },
  { "PaterJason/nvim-treesitter-sexp", opts = {}, event = "LazyFile" },
}
