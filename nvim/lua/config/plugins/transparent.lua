
return {
        "xiyaowong/transparent.nvim",
        lazy = false,
        config = function()
                require("transparent").setup({
                        extra_groups = {
                                "NvimTreeNormal",
                                "NvimTreeNormalNC",
                                "Statusline",
                                "StatuslineNC",
                                "MiniStatuslineInactive",
                                "MiniStatusline",
                                "MiniStatuslineFilename",
                                "MiniStatuslineFileinfo",
                                "MiniStatuslineDevinfo",
                                "NvimTreeStatusLine",
                                "NvimTreeStatusLineNC",
                                "StatusLineTerm",
                                "StatusLineTermNC",
                                "BufferlineFill",
                                "BufferLineOffsetSeparator",
                                "TabLineFill",
                                "EndOfBuffer",
                                "NvimTreeEndOfBuffer",
                                "NvimTreeWinSeparator",
                                "Cursor",
                                "debugPc",
                                "lCursor",
                                "CursorIM",
                                "NormalFloat",
                                "WhichKeyNormal",
                                "Todo",
                                "TelescopeNormal",
                                "TelescopeBorder",
                                "TelescopePromptBorder",
                                "TelescopePromptTitle",
                                "LspInfoBorder",
                                "CmpDocumentation",
                                "CmpDocumentationBorder",
                                "MiniPickPrompt",
                                "NormalSB",
                                "SignColoumSB",


                        },
                        exclude_groups = {},
                })

                vim.cmd("TransparentEnable")
        end,
}

