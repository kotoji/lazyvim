return {
  -- prevent nonsense diagnostics when async-trait is used
  -- https://github.com/LazyVim/LazyVim/discussions/5638#discussioncomment-12228999
  {
    "mrcjkb/rustaceanvim",
    opts = {
      server = {
        default_settings = {
          ["rust-analyzer"] = {
            procMacro = {
              ignored = {
                ["async-trait"] = vim.NIL,
              },
            },
          },
        },
      },
    },
  },
}
