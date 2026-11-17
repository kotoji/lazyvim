-- original: https://github.com/jellydn/nvim-for-webdev/tree/main

return {
  -- Jsdoc
  {
    "heavenshell/vim-jsdoc",
    ft = "javascript,typescript,typescriptreact,svelte",
    cmd = "JsDoc",
    keys = {
      { "<leader>jd", "<cmd>JsDoc<cr>", desc = "JsDoc" },
    },
    build = "make install",
  },

  -- Add Tailwind CSS LSP
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        -- rustywind for tailwindcss
        "tailwindcss-language-server",
        "rustywind",
      },
    },
  },

  -- Custom formatters
  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      local null_ls_status_ok, null_ls = pcall(require, "null-ls")
      if not null_ls_status_ok then
        return opts
      end

      local b = null_ls.builtins

      local sources = {
        -- for tailwindcss
        b.formatting.rustywind.with({
          filetypes = {
            "html",
            "css",
            "javascriptreact",
            "typescriptreact",
            "svelte",
          },
        }),
        -- Lua
        b.formatting.stylua,
      }
      opts.sources = vim.list_extend(opts.sources or {}, sources)
      return opts
    end,
  },
}
