return {
  -- add nord-vim
  { "kotoji/nord-vim" },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      --colorscheme = "nord",
    },
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = { enabled = false },
        use_libuv_file_watcher = true,
        group_empty_dirs = true, -- when true, empty folders will be grouped together
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false }, -- disable by default
    },
  },

  {
    "lewis6991/gitsigns.nvim",
    event = "LazyFile",
    opts = {
      current_line_blame = true,
      signcolumn = true,
      numhl = false,
      linehl = false,
      word_diff = false,
      signs_staged_enable = true,
    },
  },
}
