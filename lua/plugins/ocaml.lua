local language_id_of = {
  menhir = "ocaml.menhir",
  ocaml = "ocaml",
  ocamlinterface = "ocaml.interface",
  ocamllex = "ocaml.ocamllex",
  reason = "reason",
  dune = "dune",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "ocaml" })
      end
    end,
  },
  -- fail to install ocamllsp
  -- please install by yourself
  -- `opam install ocaml-lsp-server`
  -- https://github.com/williamboman/mason.nvim/discussions/1350
  -- {
  --  "williamboman/mason.nvim",
  --  opts = function(_, opts)
  --    opts.ensure_installed = opts.ensure_installed or {}
  --    vim.list_extend(opts.ensure_installed, {
  --      "ocaml-lsp",
  --    })
  --  end,
  -- },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ocamllsp = {
          get_language_id = function(_, ftype)
            return language_id_of[ftype]
          end,
          root_dir = function(fname)
            return require("lspconfig.util").root_pattern(
              "*.opam",
              "esy.json",
              "package.json",
              ".git",
              "dune-project",
              "dune-workspace",
              "*.ml"
            )(fname)
          end,
        },
      },
    },
  },
}
