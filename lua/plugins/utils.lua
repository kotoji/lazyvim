return {
  -- UFO folding
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
      {
        "luukvbaal/statuscol.nvim",
        config = function()
          local builtin = require("statuscol.builtin")
          require("statuscol").setup({
            relculright = true,
            segments = {
              { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
              { text = { "%s" }, click = "v:lua.ScSa" },
              { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
            },
          })
        end,
      },
    },
    event = "BufReadPost",
    opts = {
      provider_selector = function()
        return { "treesitter", "indent" }
      end,
    },

    init = function()
      vim.keymap.set("n", "zR", function()
        require("ufo").openAllFolds()
      end)
      vim.keymap.set("n", "zM", function()
        require("ufo").closeAllFolds()
      end)
      vim.keymap.set("n", "K", function()
        local winId = require("ufo").peekFoldedLinesUnderCursor()
        if not winId then
          vim.lsp.buf.hover()
        end
      end)
    end,
  },
  -- Folding preview, by default h and l keys are used.
  -- On first press of h key, when cursor is on a closed fold, the preview will be shown.
  -- On second press the preview will be closed and fold will be opened.
  -- When preview is opened, the l key will close it and open fold. In all other cases these keys will work as usual.
  {
    "anuvyklack/fold-preview.nvim",
    event = "BufReadPost",
    dependencies = "anuvyklack/keymap-amend.nvim",
    config = true,
  },

  -- CSPell
  -- Auto install those tools with mason
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = { "codespell", "misspell", "cspell" },
    },
  },
  -- Set up null-ls to check spelling
  {
    "nvimtools/none-ls.nvim",
    keys = {
      { "<leader>cn", "<cmd>NullLsInfo<cr>", desc = "NullLs Info" },
    },
    dependencies = { "mason.nvim", "davidmh/cspell.nvim" },
    event = { "BufReadPre", "BufNewFile" },
    opts = function(_, opts)
      local cspell = require("cspell")
      local ok, none_ls = pcall(require, "null-ls")
      if not ok then
        return opts
      end

      local b = none_ls.builtins

      local sources = {
        -- spell check
        b.diagnostics.codespell,
        b.diagnostics.misspell,
        -- cspell
        cspell.diagnostics.with({
          -- Set the severity to HINT for unknown words
          diagnostics_postprocess = function(diagnostic)
            diagnostic.severity = vim.diagnostic.severity["HINT"]
          end,
        }),
        cspell.code_actions,
      }
      opts.sources = vim.list_extend(opts.sources or {}, sources)
      return opts
    end,
  },

  -- Lsp Lens
  {
    -- Displaying references and definition infos upon functions like JB's IDEA.
    "VidocqH/lsp-lens.nvim",
    event = "BufRead",
    opts = {
      enable = true,
      include_declaration = false, -- Reference include declaration
      sections = { -- Enable / Disable specific request
        definition = false,
        references = true,
        implements = false,
        git_authors = true,
      },
    },
    keys = {
      {
        -- LspLensToggle
        "<leader>uL",
        "<cmd>LspLensToggle<CR>",
        desc = "LSP Len Toggle",
      },
    },
  },

  -- Dim
  {
    -- Dim the unused variables and functions using lsp and treesitter.
    "narutoxy/dim.lua",
    event = "BufRead",
    dependencies = { "nvim-treesitter/nvim-treesitter", "neovim/nvim-lspconfig" },
    config = true,
  },
}
