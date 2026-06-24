vim.g.mapleader = " "

local keymap = vim.keymap -- for consiseness

-- main keymaps
keymap.set("i", "jk", "<ESC>", {desc = "Exit insert mode with jk"})
keymap.set("n", "<leader>q", ":q<CR>", {desc = "Quit/Exit the file"})
keymap.set("n", "<leader>k", ":q!<CR>", {desc = "Quit/Exit the file without saving"})
keymap.set("n", "<leader>w", ":w<CR>", {desc = "Write to/Save the file"})


-- increment/decrement number
keymap.set("n", "<leader>+", "<C-a>", {desc = "Increment number"}) -- increment
keymap.set("n", "<leader>-", "<C-x>", {desc = "Decrement number"}) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", {desc = "Split window vertically"}) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", {desc = "Split window horizontally"}) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", {desc = "Make splits equal size"}) -- make split windows equal size
keymap.set("n", "<leader>sx", "<cmd>close<CR>", {desc = "Close current split"}) -- close current split window

-- tabs management
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", {desc = "Open new tab"}) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", {desc = "Close current tab"}) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", {desc = "Go to next tab"}) -- go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", {desc = "Go to previous tab"}) -- go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", {desc = "Open current buffer in new tab"}) -- open current buffer in new tab


-- plugins --

-- nvimtree plugin
keymap.set("n", "<leader>ee", "<cmd>Neotree<CR>", {desc = "Toggle file Explorer plugin"}) -- toggle file explorer
