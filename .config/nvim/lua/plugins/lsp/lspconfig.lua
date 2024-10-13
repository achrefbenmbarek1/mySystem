local config = function()
  local lspconfig = require("lspconfig")
  local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
  end

  local cmp_nvim_lsp = require("cmp_nvim_lsp")
  local keymap = vim.keymap
  local opts = { noremap = true, silent = true }

  local on_attach = function(client, buffnr)
    opts.buffer = buffnr
    opts.desc = "Show LSP references"
    keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

    opts.desc = "Go to declaration"
    keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

    opts.desc = "Show LSP definitions"
    keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

    opts.desc = "Show LSP implementations"
    keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

    opts.desc = "Show LSP type definitions"
    keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

    opts.desc = "See available code actions"
    keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

    opts.desc = "Smart rename"
    keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

    opts.desc = "Show this buffer diagnostics in quickfix"
    keymap.set("n", "<leader>ldq", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

    opts.desc = "Show line diagnostics"
    keymap.set("n", "<leader>lds", vim.diagnostic.open_float, opts)

    opts.desc = "Go to previous diagnostic"
    keymap.set("n", "<leader>ldp", vim.diagnostic.goto_prev, opts)

    opts.desc = "Go to next diagnostic"
    keymap.set("n", "<leader>ldn", vim.diagnostic.goto_next, opts)

    opts.desc = "Show documentation for what is under cursor"
    keymap.set("n", "K", vim.lsp.buf.hover, opts)

    opts.desc = "Restart LSP"
    keymap.set("n", "<leader>lrs", ":LspRestart<CR>", opts)
  end
  local function capture_command_output(command)
    local handle = io.popen(command)
    local result = handle:read("*a") -- Read all output
    handle:close()
    return result
  end
  local on_attach_for_angular = function()
    on_attach()
    opts = { noremap = true, silent = true }
    local ng = require("ng")
    vim.keymap.set("n", "<leader>at", ng.goto_template_for_component, opts)
    vim.keymap.set("n", "<leader>ac", ng.goto_component_with_template_file, opts)
    vim.keymap.set("n", "<leader>aT", ng.get_template_tcb, opts)
  end

  local on_attach_for_omnisharp = function()
    on_attach()
     opts = { noremap = true, silent = true }
    local extended_omnisharp = require('omnisharp_extended')
    vim.keymap.set("n", "gR", extended_omnisharp.telescope_lsp_references(), opts)
    vim.keymap.set("n", "gd", extended_omnisharp.telescope_lsp_definition({ jump_type = "vsplit" }), opts)
    vim.keymap.set("n", "gD", extended_omnisharp.telescope_lsp_type_definition(), opts)
    vim.keymap.set("n", "gi", extended_omnisharp.telescope_lsp_implementation(), opts)
  end
  local capabilities = cmp_nvim_lsp.default_capabilities()
  -- local Omnisharp = "/home/achref/.nix-profile/lib/omnisharp-roslyn/OmniSharp.dll"
  local Omnisharp = capture_command_output("command -v OmniSharp")
  Omnisharp = Omnisharp:gsub("%s+$", "") -- Remove trailing newline or whitespac
  Omnisharp = string.gsub(Omnisharp, "/bin/OmniSharp", "/lib/omnisharp-roslyn/OmniSharp.dll")
  -- local Omnisharp = "/home/achref/.local/share/nvim/mason/packages/omnisharp/libexec/OmniSharp.dll"
  lspconfig["lua_ls"].setup({
    capabilities = capabilities,

    on_attach = on_attach,
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          library = {
            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
            [vim.fn.stdpath("config") .. "/lua"] = true,
          },
        },
      },
    },
  })
  local project_library_path_typescript =
    "/home/achref/.fnm/node-versions/v18.13.0/installation/lib/node_modules/typescript/"
  local project_library_path_ngserver =
    "/home/achref/.fnm/node-versions/v18.13.0/installation/lib/node_modules/@angular/language-server/"
  local cmd = {
    "ngserver",
    "--stdio",
    "--tsProbeLocations",
    project_library_path_typescript,
    "--ngProbeLocations",
    project_library_path_ngserver,
  }

  lspconfig["tsserver"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })

  lspconfig["angularls"].setup({
    cmd = cmd,
    capabilities = capabilities,
    on_attach = on_attach_for_angular,
    on_new_config = function(new_config, new_root_dir)
      new_config.cmd = cmd
    end,
  })

  lspconfig["jdtls"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })

  lspconfig["pyright"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })

  lspconfig["ansiblels"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })

  lspconfig["omnisharp"].setup({
    cmd = { "dotnet", Omnisharp },
    enable_import_completion = true,
    capabilities = capabilities,
    on_attach = on_attach_for_omnisharp,
    -- handlers = {
    --   ["textDocument/definition"] = require("omnisharp_extended").handler,
    --   ["textDocument/typeDefinition"] = require("omnisharp_extended").type_definition_handler,
    --   ["textDocument/references"] = require("omnisharp_extended").references_handler,
    --   ["textDocument/implementation"] = require("omnisharp_extended").implementation_handler,
    -- },
  })

  lspconfig["dockerls"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })

  lspconfig["bashls"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })

  lspconfig["docker_compose_language_service"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })
end

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    "Hoffs/omnisharp-extended-lsp.nvim",
  },
  config = config,
}
