return {
  {
    "echasnovski/mini.nvim",
    version = false,
    config = function()
      local statusline = require("mini.statusline")

      statusline.setup({
        content = {
          active = function()
            local mode_str, mode_name = MiniStatusline.section_mode({ trunc_width = 120 })
            local left, right = "", ""

            local mode_group = statusline.combine_groups({
              { hl = "MiniStatuslineModeSide" .. mode_name, strings = { left } },
              { hl = "MiniStatuslineMode" .. mode_name,     strings = { mode_str } },
              { hl = "MiniStatuslineModeSide" .. mode_name, strings = { right } },
            })

            local git        = MiniStatusline.section_git({ trunc_width = 40 })
            local diff       = MiniStatusline.section_diff({ trunc_width = 75 })
            local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
            local filename   = MiniStatusline.section_filename({ trunc_width = 140 })
            local fileinfo   = MiniStatusline.section_fileinfo({ trunc_width = 120 })
            local location   = MiniStatusline.section_location({ trunc_width = 75 })

            return statusline.combine_groups({
              { hl = "MiniStatuslineDevinfo",   strings = { git, diff, diagnostics } },
              { hl = "MiniStatuslineFilename",  strings = { filename } },
              "%=",
              { hl = "MiniStatuslineFileinfo",  strings = { fileinfo } },
              { hl = "MiniStatuslineLocation",  strings = { location } },
              mode_group, -- pill indicator
            })
          end,
        },
      })

      require("mini.cursorword").setup()
      require("mini.notify").setup({ use_icons = true })
      require("mini.icons").setup({ use_icons = true })
      require("mini.animate").setup()

      local colors = {
        Normal  = "#5f87ff",
        Insert  = "#5fd75f",
        Visual  = "#ffaf00",
        Replace = "#d75f5f",
        Command = "#af5fff",
        Other   = "#5f5f5f",
      }

      for mode, color in pairs(colors) do
        vim.api.nvim_set_hl(0, "MiniStatuslineMode" .. mode, {
          fg = "#ffffff",
          bg = color,
          bold = true,
        })
        vim.api.nvim_set_hl(0, "MiniStatuslineModeSide" .. mode, {
          fg = color,
          bg = "NONE",
        })
      end
    end,
  },
}
