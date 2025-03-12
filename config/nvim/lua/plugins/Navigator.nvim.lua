return {
  "numToStr/Navigator.nvim",
  config = function()
    local nvim_tmux_nav = require("Navigator")

    nvim_tmux_nav.setup({
      disable_on_zoom = true,
      mux = "auto",
    })
  end,
  keys = {
    { "<C-h>", "<CMD>NavigatorLeft<CR>", mode = { "n", "t" } },
    { "<C-l>", "<CMD>NavigatorRight<CR>", mode = { "n", "t" } },
    { "<C-k>", "<CMD>NavigatorUp<CR>", mode = { "n", "t" } },
    { "<C-j>", "<CMD>NavigatorDown<CR>", mode = { "n", "t" } },
    { "<C-\\>", "<CMD>NavigatorPrevious<CR>", mode = { "n", "t" } },
  },
}
