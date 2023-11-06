local keymap = vim.keymap
local config = function()
  local telescope = require('telescope')
  local actions = require('telescope.actions')
  telescope.setup({
    defaults = {
      vimgrep_arguments = {
        "rg",
        "-L",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
      },
      prompt_prefix = "   ",
      selection_caret = "  ",
      entry_prefix = "  ",
      initial_mode = "insert",
      selection_strategy = "reset",
      sorting_strategy = "ascending",
      layout_strategy = "horizontal",
      layout_config = {
        horizontal = {
          prompt_position = "top",
          preview_width = 0.55,
          results_width = 0.8,
        },
        vertical = {
          mirror = false,
        },
        width = 0.87,
        height = 0.80,
        preview_cutoff = 120,
      },
      file_sorter = require("telescope.sorters").get_fuzzy_file,
      file_ignore_patterns = { "node_modules" },
      generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
      path_display = { "truncate" },
      winblend = 0,
      border = {},
      borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      color_devicons = true,
      set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
      file_previewer = require("telescope.previewers").vim_buffer_cat.new,
      grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
      qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
      -- Developer configurations: Not meant for general override
      buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
      mappings = {
        i = {
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist
        },
        n = {
          ["q"] = "close",
        }
      },
    },

    --extensions_list = { "themes", "terms" },
  })
  telescope.load_extension("fzf")
end

return {
    'nvim-telescope/telescope.nvim', 
      tag = '0.1.4',
      event = "VeryLazy",
      dependencies = { 
    'nvim-lua/plenary.nvim',
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make"
    },
  },
      config = config,
      keys = {
            keymap.set("n","<leader>ff",  "<cmd> Telescope find_files <CR>" ),
            keymap.set("n","<leader>fa", "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>" ),
            keymap.set("n","<leader>fg", "<cmd> Telescope live_grep <CR>" ),
            keymap.set("n","<leader>fb", "<cmd> Telescope buffers <CR>" ),
            keymap.set("n","<leader>fh", "<cmd> Telescope help_tags <CR>" ),
            keymap.set("n","<leader>fo", "<cmd> Telescope oldfiles <CR>" ),
            keymap.set("n","<leader>fz", "<cmd> Telescope current_buffer_fuzzy_find <CR>" ),
            keymap.set("n","<leader>fgc", "<cmd> Telescope git_commits <CR>" ),
            keymap.set("n","<leader>fgs", "<cmd> Telescope git_status <CR>" ),
            keymap.set("n","<leader>fth", "<cmd> Telescope themes <CR>" ),
            keymap.set("n","<leader>ftm", "<cmd> Telescope marks <CR>" ),
            --keymap.set("n","<leader>ftp",  "<cmd> lua require'telescope'.extensions.project.project{} <CR>"),

      }
    }
