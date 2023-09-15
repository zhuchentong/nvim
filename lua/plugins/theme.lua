return   {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("tokyonight").setup({
      style = "storm", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
      transparent = false -- Enable this to disable setting the background color
    })
    -- load the colorscheme here
    vim.cmd("colorscheme tokyonight")
  end,
}