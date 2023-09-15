-- 设置Leader键
vim.g.mapleader=" "
vim.g.maplocalleader=" "

-- 重命名映射
local map = vim.api.nvim_set_keymap
local opt = {noremap = ture, silent= true}

-- [NORMAL MODE] --

-- windows 分屏快捷键
map("n", "<leader>sv", "<C-w>v", opt)
map("n", "<leader>sh", "<C-w>s", opt)

-- Alt + hjkl  窗口之间跳转
map("n", "<A-h>", "<C-w>h", opt)
map("n", "<A-j>", "<C-w>j", opt)
map("n", "<A-k>", "<C-w>k", opt)
map("n", "<A-l>", "<C-w>l", opt)


-- 左右比例控制
map("n", "<A-Right>", ":vertical resize -2<CR>", opt)
map("n", "<A-Left>", ":vertical resize +2<CR>", opt)

-- 上下比例
map("n", "<A-Up>", ":resize -2<CR>", opt)
map("n", "<A-Down>", ":resize +2<CR>", opt)


map("n", "<leader>s=", "<C-w>=", opt)


-- 取消高亮
map("n", "<leader>nh", ":nohl<CR>", opt)

-- [VISUAL MODE] --

-- 上下移动选中文本
map("v", "J", ":move '>+1<CR>gv-gv", opt)
map("v", "K", ":move '<-2<CR>gv-gv", opt)
