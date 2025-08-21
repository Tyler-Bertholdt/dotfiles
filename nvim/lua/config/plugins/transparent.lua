
return {
        "xiyaowong/transparent.nvim",
        lazy = false,
        config = function()
                require("transparent").setup({
                        extra_groups = {
                                "NvimTreeNormal",     -- Nvim-tree background
                                "NvimTreeNormalNC",
                                "Statusline",
                                "StatuslineNC",
                                "MiniStatuslineInactive",
                                "MiniStatusline",
                                "MiniStatuslineActive",
                                "NvimTreeStatusLine",
                                "NvimTreeStatusLineNC",
                                "StatusLineTerm",
                                "StatusLineTermNC"                                                                                                                             
                        },
                        exclude_groups = {},
                })

                vim.cmd("TransparentEnable")
        end,
}

