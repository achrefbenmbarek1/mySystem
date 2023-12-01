local config = function()
  local conform = require("conform")
  local keymap = vim.keymap
  conform.setup({
    formatters_by_ft = {
      javascript = { "prettier" },
      typescript = { "prettier" },
      javascriptreact = { "prettier" },
      typescriptreact = { "prettier" },
      css = { "prettier" },
      html = { "prettier" },
      json = { "prettier" },
      lua = { "stylua" },
      python = { "isort", "black" },
      ansible = { "ansible-lint" },
    },
    -- format_on_save = {
    --   lsp_fallback = true,
    --   async = false,
    --   timeout_ms = 500,
    -- },
  })
  keymap.set({ "n", "v" }, "<leader>lf", function()
    conform.format({
      lsp_fallback = true,
      async = false,
      timeout_ms = 500,
    })
  end, { desc = "Format file or range(in the case of visual mode)" })
end

return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = config,
}
