require("config.lazy")
require("config.remap")
require('nvim-web-devicons').setup { default = true }
-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- setup with some options
require("nvim-tree").setup({
        sort = {
                sorter = "case_sensitive",
        },
        view = {
                width = 30,
        },
        renderer = {
                group_empty = true,
        },
        filters = {
                dotfiles = true,
        },
})

vim.opt.backup = false                                  -- creates a backup file
vim.opt.conceallevel = 0                                -- so that `` is visible in markdown files
vim.opt.hlsearch = true                                 -- highlight all matches on previous search pattern
vim.opt.ignorecase = true                               -- ignore case in search patterns
vim.opt.mouse = "a"                                     -- allow the mouse to be used in neovim
vim.opt.showmode = false                                -- we don't need to see things like -- INSERT -- anymore
vim.opt.termguicolors = true                            -- set term gui colors (most terminals support this)
vim.opt.undofile = true                                 -- enable persistent undo
vim.opt.updatetime = 100                                -- faster completion (4000ms default)
vim.opt.writebackup = false                             -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.expandtab = true                                -- convert tabs to spaces
vim.opt.cursorline = true                              -- highlight the current line
vim.opt.number = true                                   -- set numbered lines
vim.opt.relativenumber = false                           -- set relative numbered lines
vim.opt.numberwidth = 1                                 -- set number column width to 2 {default 4}
vim.opt.wrap = true                                    -- display lines as one long line
-- vim.opt.scrolloff = 8                                   -- Makes sure there are always eight lines of context
-- vim.opt.sidescrolloff = 8                               -- Makes sure there are always eight lines of context
vim.opt.showcmd = false           -- Don't show the command in the last line
vim.opt.guifont = "monospace:h17" -- the font used in graphical neovim applications
vim.opt.title = true              -- set the title of window to the value of the titlestring
vim.opt.confirm = true            -- confirm to save changes before exiting modified buffer

vim.opt.guicursor = "n-v-c:block-blinkon100,i:ver25-blinkon50"

vim.opt.cursorlineopt = "number"
-- vim.opt.tabstop = 2                           -- insert 2 spaces for a tab
-- vim.opt.laststatus = 0 -- Always display the status line
vim.o.clipboard = "unnamedplus"


