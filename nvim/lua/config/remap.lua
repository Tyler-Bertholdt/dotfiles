vim.g.mapleader = " "
-- Functions Calls 
local ui = require("harpoon.ui")
local mark=require("harpoon.mark")
-- Harpoon
vim.keymap.set("n", "<leader>ha", mark.add_file, { desc = 'Add File To Menu' })  
vim.keymap.set("n", "<leader>hh", ui.toggle_quick_menu, { desc = 'Quick Menu' })  
vim.keymap.set("n", "<leader>hn", ui.nav_next, { desc = 'Next Harpoon File' })  
vim.keymap.set("n", "<leader>hp", ui.nav_prev, { desc = 'Previous Harpoon File' })  

-- NvimTree  
vim.cmd('command! OpenTree NvimTreeOpen')  
vim.cmd('command! CloseTree NvimTreeClose')  
vim.keymap.set('n', '<leader>tt', ':OpenTree<CR>', { desc = 'Open Nvim Tree' })  
vim.keymap.set('n', '<leader>tc', ':CloseTree<CR>', { desc = 'Close Nvim Tree' })  

-- Windows  
vim.cmd('command! SplitWindow vsplit')  
vim.cmd('command! CloseWindow wincmd c')  
vim.cmd('command! SwitchWindow wincmd w')  
vim.keymap.set('n', '<leader>ws', ':SplitWindow<CR>', { desc = 'Split Window' })  
vim.keymap.set('n', '<leader>wc', ':CloseWindow<CR>', { desc = 'Close Window' })  
vim.keymap.set('n', '<leader>ww', ':SwitchWindow<CR>', { desc = 'Switch Window' })  

-- Telescope  
vim.cmd('command! FindFiles Telescope find_files')  
vim.keymap.set('n', '<leader>ff', ':FindFiles<CR>', { desc = 'Find Files' })  

-- File Remaps   
vim.keymap.set("n", "<leader>fs", ":w<CR>", { desc = "Save file" })  
vim.keymap.set("n", "<C-s>", ":w<CR>", { desc = "Save file" })  
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>", {noremap=true , desc = "Save file" })  
vim.keymap.set("n", "<leader>fq", ":q<CR>", { desc = "Quit file" })  
vim.keymap.set("n", "<leader>fu", ":so<CR>", { desc = "Update file" })  
vim.keymap.set("n", "<leader>fsq", ":wq<CR>", { desc = "Save & Quit file" })  
vim.keymap.set("n", "<leader>fsqa", ":wqa<CR>", { desc = "Save & Quit All files" })  

-- Clipboard  
vim.keymap.set("n", "<leader>cy", '"+y', { desc = "Yank to system clipboard" })  
vim.keymap.set("n", "<C-c>", '"+y', { desc = "Yank to system clipboard" })  
vim.keymap.set("v", "<leader>cy", '"+y', { desc = "Yank selection to system clipboard" })  
vim.keymap.set("v", "<C-c>", '"+y', { desc = "Yank selection to system clipboard" })  
vim.keymap.set("n", "<leader>cp", '"+p', { desc = "Paste from system clipboard" })  
vim.keymap.set("n", "<C-v>", '"+p', { desc = "Paste from system clipboard" })  
vim.keymap.set("i", "<C-v>", '<Esc>"+p i', {noremap=true ,  desc = "Paste from system clipboard" })  
vim.keymap.set("v", "<C-v>", '"+p', {noremap=true ,  desc = "Paste from system clipboard" })  
vim.keymap.set("v", "<leader>cp", '"+p', { desc = "Paste into selection from system clipboard" })  
vim.keymap.set("v", "<C-v>", '"+p', { desc = "Paste into selection from system clipboard" })  
vim.keymap.set("n", "<C-a>", "ggVG", { desc = "Select All" })  
vim.keymap.set("n", "<leader>ca", "ggVG", { desc = "Select All" })  
--Buffers Remap  

vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next Buffer" })  
vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Previous Buffer" })  
vim.keymap.set("n", "<leader>bh", "<cmd>BufferLineMoveNext<CR>", { desc = "Move Buffer Right" })  
vim.keymap.set("n", "<leader>bg", "<cmd>BufferLineMovePrev<CR>", { desc = "Move Buffer Left" })  
vim.keymap.set("n", "<leader>bd", "<cmd>BufferLinePickClose<CR>", { desc = "Pick Buffer to Close" }) 
vim.keymap.set("n", "<leader>bb", "<cmd>BufferLinePick<CR>", { desc = "Pick Buffer to Focus" })  
vim.keymap.set("n", "<leader>bx", "<cmd>bd<CR>", { desc = "Close Current Buffer" })  

-- System remap  
vim.keymap.set("n", "<CR>", "i" , { desc = "Enter To Insert" })  
vim.keymap.set("n", "<S-j>", "Vyp" , { desc = "Paste Line Under" })  
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", {noremap=true , desc = "Move lines up" })  
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { noremap=true , desc = "Move line down" })  
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { noremap=true , desc = "Move selected lines up" })  
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { noremap=true , desc = "Move selected lines down" })  
vim.keymap.set("n", "<leader>rp", ":terminal python3 '%'<CR>i", { desc = "Run Current Python File"})
vim.keymap.set("n", "<leader>l", ":TransparentToggle<CR>" , {desc = "Transparent Toggle"})

-- MultiCursor

vim.keymap.set({ "n", "v" }, "<C-n>", function()
  local ok, mc = pcall(require, "multicursors")
  if ok then mc.start() end
end, { desc = "Multicursor: Start" })
-- Lsp
vim.keymap.set("i", "<C-Space>", "<cmd>lua vim.fn.complete()<CR>", { desc = "Trigger Autocomplete" })
vim.keymap.set("i", "<C-j>", function()
        local cmp = require("cmp")
        if cmp.visible() then cmp.scroll_docs(4) end
end, { desc = "Cmp Scroll Down" })

vim.keymap.set("i", "<C-k>", function()
        local cmp = require("cmp")
        if cmp.visible() then cmp.scroll_docs(-4) end
end, { desc = "Cmp ScrolS Up" })

vim.keymap.set("n", "<leader>z", "z=", { desc = "Suggest spelling corrections" })

