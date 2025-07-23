return {
  {
    "smoka7/multicursors.nvim",
    event = "VeryLazy",
    dependencies = { "nvimtools/hydra.nvim" },
    opts = {
      DEBUG_MODE = false,
      create_commands = true,
      updatetime = 50,
      nowait = true,
      mode_keys = {
        append = "a",
        change = "c",
        extend = "e",
        insert = "i",
      },
      normal_keys = nil,
      insert_keys = nil,
      extend_keys = nil,
      hint_config = {
        show_hints = false, 
        float_opts = {
          border = "none",
        },
        position = "bottom",
      },
      generate_hints = {
        normal = false,
        insert = false,
        extend = false,
        config = {
          column_count = nil,
          max_hint_length = 25,
        },
      },
    },
  },
}

