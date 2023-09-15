return {
    "akinsho/bufferline.nvim",
    lazy = true,
    branch = "main",
    event = "User FileOpened",
    dependencies = {
      "nvim-tree/nvim-web-devicons", 
      "moll/vim-bbye",
    },
    keys = {
      -- b切换左右Ta
      { "<C-h>", "<cmd>BufferLineCyclePrev<CR>" },
      { "<C-l>", "<cmd>BufferLineCycleNext<CR>" },
      -- 关闭当前Tab
      { "<C-c>", "<cmd>Bdelete!<CR>" },
      -- 关闭其他TAB
      { "<leader>bc", "<cmd>BufferLineCloseRight<CR>:BufferLineCloseLeft<CR>"},
    },
    config = function()
        require("bufferline").setup({
            options = {
                close_command = "Bdelete! %d",
                right_mouse_command = "Bdelete! %d",
                -- 关闭图标
                buffer_close_icon = 'x',
                -- 左侧让出 nvim-tree 的位置，显示文字 File Explorer
                offsets = {{
                    filetype = "NvimTree",
                    text = "File Explorer",
                    highlight = "Directory",
                    text_align = "left"
                }},
                -- 使用 nvim 内置 LSP
                ---@diagnostic disable-next-line: assign-type-mismatch
                diagnostics = "nvim_lsp",
                -- 可选，显示 LSP 报错图标
                ---@diagnostic disable-next-line: unused-local
                diagnostics_indicator = function(count, level, diagnostics_dict, context)
                    local s = " "
                    for e, n in pairs(diagnostics_dict) do
                        local sym = e == "error" and " " or (e == "warning" and " " or "")
                        s = s .. n .. sym
                    end
                    return s
                end
            }
        })
    end
}
