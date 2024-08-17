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
    "williamboman/mason.nvim",
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

  --  LSP Config
  {
    "lvimuser/lsp-inlayhints.nvim",
    ft = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "json",
      "jsonc",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
      "svelte",
    },
    enabled = true,
    opts = {
      debug_mode = false,
    },
    config = function(_, options)
      vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
      vim.api.nvim_create_autocmd("LspAttach", {
        group = "LspAttach_inlayhints",
        callback = function(args)
          if not (args.data and args.data.client_id) then
            return
          end

          local bufnr = args.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          require("lsp-inlayhints").on_attach(client, bufnr)
        end,
      })
      require("lsp-inlayhints").setup(options)
      -- define key map for toggle inlay hints: require('lsp-inlayhints').toggle()
      vim.api.nvim_set_keymap(
        "n",
        "<leader>uI",
        "<cmd>lua require('lsp-inlayhints').toggle()<CR>",
        { noremap = true, silent = true }
      )
    end,
  },
}
