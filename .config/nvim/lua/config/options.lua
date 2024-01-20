local opt = vim.opt

opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.smartindent = true
opt.wrap = true

opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true

opt.relativenumber = true
opt.number = true
opt.termguicolors = true
-- a colomn to remind of the length of the code in one line
-- give it a number between two quotes and it will create a colomn in a position that is dependent on the number
opt.colorcolumn = ""
-- opt.signcolumn = "yes:1"
opt.signcolumn = "number"
opt.cmdheight = 1
opt.scrolloff = 10
opt.completeopt = "menuone,noinsert,noselect" --for autocompletion

opt.hidden = true --change buffers without saving
opt.errorbells = false
opt.swapfile = false
opt.backup = false
opt.undodir = vim.fn.expand("~/.local/share/nvim/undodir")
opt.undofile = true
opt.backspace = "indent,eol,start"
opt.splitright = true
opt.splitbelow = true
opt.autochdir = false
opt.iskeyword:append("-") -- will consider strings that are separated by - as one word
opt.mouse = ""
opt.modifiable = true
opt.encoding = "UTF-8"
opt.virtualedit = "block"
