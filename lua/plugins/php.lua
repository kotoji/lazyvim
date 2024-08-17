return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        intelephense = {
          format = {
            enable = true,
            brace = "psr12",
          },
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "php" })
      end
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      local sources = {
        nls.builtins.formatting.blade_formatter,
        nls.builtins.diagnostics.phpstan.with({
          extra_args = {
            "--memory-limit=2G",
          },
        }),
      }
      opts.sources = vim.list_extend(opts.sources or {}, sources)
      return opts
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "blade-formatter",
        "html-lsp",
        "intelephense",
        "php-debug-adapter",
        "phpstan",
      },
    },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = "mason.nvim",
    cmd = { "DapInstall", "DapUninstall" },
    opts = {
      ensure_installed = {
        "php",
      },
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_setup = true,
      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {
        function(config)
          -- all sources with no handler get passed here

          -- Keep original functionality
          require("mason-nvim-dap").default_setup(config)
        end,
        php = function(config)
          config.configurations = {
            {
              type = "php",
              request = "launch",
              name = "Listen for Xdebug",
              port = 9003,
              pathMappings = {
                ["/var/www/html"] = "${workspaceFolder}",
              },
            },
          }
          require("mason-nvim-dap").default_setup(config) -- don't forget this!
        end,
      },
    },
  },
  {
    "jwalton512/vim-blade",
  },
}
