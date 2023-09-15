return {
  "rcarriga/nvim-notify",
  event = "VeryLazy",
  config = function()
    notify = require("notify")
    notify.setup({
      stages = "static",
      timeout = 5000,
    })
    
    vim.notify = notify
  end,
}
