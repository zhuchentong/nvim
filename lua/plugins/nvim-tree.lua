local TREE_WIDTH = 30

local git_icons = {
  unstaged = "",
  staged = "",
  unmerged = "",
  renamed = "➜",
  untracked = "",
  deleted = "",
  ignored = "◌",
}

local keymappings = {
  { key = { "<CR>", "o", "<2-LeftMouse>" }, action = "edit" },
  -- <C-e> keymapping cannot be set because it's used for toggling nvim-tree
  -- { key = "<C-e>",                        action = "edit_in_place" },
  { key = { "O" }, action = "edit_no_picker" },
  { key = { "<2-RightMouse>", "<C-]>" }, action = "cd" },
  { key = "<C-v>", action = "vsplit" },
  { key = "<C-x>", action = "split" },
  { key = "<C-t>", action = "tabnew" },
  { key = "<", action = "prev_sibling" },
  { key = ">", action = "next_sibling" },
  { key = "P", action = "parent_node" },
  { key = "<BS>", action = "close_node" },
  { key = "<Tab>", action = "preview" },
  { key = "K", action = "first_sibling" },
  { key = "J", action = "last_sibling" },
  { key = "I", action = "toggle_ignored" },
  { key = "H", action = "toggle_dotfiles" },
  { key = "R", action = "refresh" },
  { key = "a", action = "create" },
  { key = "d", action = "remove" },
  { key = "D", action = "trash" },
  { key = "r", action = "rename" },
  { key = "<C-r>", action = "full_rename" },
  { key = "x", action = "cut" },
  { key = "c", action = "copy" },
  { key = "p", action = "paste" },
  { key = "y", action = "copy_name" },
  { key = "Y", action = "copy_path" },
  { key = "gy", action = "copy_absolute_path" },
  { key = "[c", action = "prev_git_item" },
  { key = "]c", action = "next_git_item" },
  { key = "-", action = "dir_up" },
  { key = "s", action = "system_open" },
  { key = "q", action = "close" },
  { key = "g?", action = "toggle_help" },
  { key = "W", action = "collapse_all" },
  { key = "S", action = "search_node" },
}



return {
  "nvim-tree/nvim-tree.lua",
  lazy = true,
  keys = {
    { "<leader>tt", "<cmd>lua require('nvim-tree.api').tree.toggle()<CR>", desc = "NvimTree" },
  },
  event = "VeryLazy",
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    local nvim_tree = require("nvim-tree")
    local nvim_tree_events = require("nvim-tree.events")

    nvim_tree.setup({
      --  git = {
      --    enable = false,
      --  },
        update_cwd = true,
        update_focused_file = {
            enable = true,
            update_cwd = true,
        },
        -- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
        sync_root_with_cwd = true,
        --false by default, will change cwd of nvim-tree to that of new buffer's when opening nvim-tree
        respect_buf_cwd = true,
        -- show lsp diagnostics in the signcolumn
        diagnostics = {
          enable = false,
          icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
          },
        },
        renderer = {
          group_empty = true,
          highlight_git = true,
          highlight_opened_files = "none",
          root_folder_label = ":~",
          indent_markers = {
            enable = false,
            icons = {
              corner = "└ ",
              edge = "│ ",
              none = "  ",
            },
          },
          icons = {
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = true,
              modified = true,
            },
            glyphs = {
              git = git_icons,
            },
          },
        },
        -- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
        update_focused_file = {
          -- enables the feature
          enable = true,
          -- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
          -- only relevant when `update_focused_file.enable` is true
          update_root = true,
          -- list of buffer names / filetypes that will not update the cwd if the file isn't found under the current root directory
          -- only relevant when `update_focused_file.update_cwd` is true and `update_focused_file.enable` is true
          ignore_list = {},
        },
        -- configuration options for the system open command (`s` in the tree by default)
        filters = {
          dotfiles = false,
          custom = {},
        },
        actions = {
          use_system_clipboard = true,
          change_dir = {
            enable = true,
            global = false,
            restrict_above_cwd = false,
          },
          open_file = {
            quit_on_open = false,
            -- if true the tree will resize itself after opening a file
            resize_window = false,
            window_picker = {
              enable = true,
              chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
              exclude = {
                filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
                buftype = { "nofile", "terminal", "help" },
              },
            },
          },
        },
        view = {
          -- width of the window, can be either a number (columns) or a string in `%`
          width = TREE_WIDTH,
          hide_root_folder = false,
          -- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
          side = "left",
          mappings = {
            -- custom only false will merge the list with the default mappings
            -- if true, it will only use your list to set the mappings
            custom_only = true,
            -- list of mappings to set on the tree manually
            list = keymappings,
          },
          number = false,
          relativenumber = false,
        },
      })

      vim.api.nvim_create_autocmd("BufEnter", {
        nested = true,
        callback = function()
          if #vim.api.nvim_list_wins() == 1 and require("nvim-tree.utils").is_nvim_tree_buf() then
            vim.cmd "quit"
          end
        end
      })
      
      require("nvim-tree.api").tree.toggle({ focus = false , find_file = true })
  end,
}
