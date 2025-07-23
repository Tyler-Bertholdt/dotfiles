return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = true,
  priority = 1000,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
require("nvim-tree").setup({
  view = {
    width = 30,
    side = "left",
                                preserve_window_proportions = false,
                        },
                        renderer = {
                                group_empty = true,
                        },
                        diagnostics = {
                                enable = false,
                                show_on_dirs = false,
                                show_on_open_dirs = true,
                                debounce_delay = 500,
                                severity = {
                                        min = vim.diagnostic.severity.HINT,
                                        max = vim.diagnostic.severity.ERROR,
                                },
                                icons = {
                                        hint = "",
                                        info = "",
                                        warning = "",
                                        error = "",
                                },
                        },

                })
        end,
}
