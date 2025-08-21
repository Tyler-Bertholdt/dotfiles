return {
	{
  "folke/tokyonight.nvim",
  lazy = false,
  style = "night",
  transparent = false,
  priority = 1000,
  terminal_colors = true,
    styles = {
      sidebars = "dark",
      floats = "dark",
    },
 config = function(_, opts)
    require("tokyonight").setup(opts)
    vim.cmd("colorscheme tokyonight")
  end,
},
}

