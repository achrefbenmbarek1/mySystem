return {
  "kristijanhusak/vim-dadbod-completion",
  event = "VeryLazy",
  config = function()
    require("cmp").setup.buffer({ sources = { { name = "vim-dadbod-completion" } } })
  end,
}
