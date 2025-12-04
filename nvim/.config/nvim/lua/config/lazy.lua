-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
--

-- Neovim Configuration
-- by Stephan Raabe (2023)
-- Converted to Lua
-- -----------------------------------------------------
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.opt.compatible = false        -- disable compatibility to old-time vi
vim.opt.showmatch = true         -- show matching brackets
vim.opt.ignorecase = true        -- case insensitive matching
vim.opt.mouse = 'a'              -- enable mouse support in all modes
vim.opt.hlsearch = true          -- highlight search results
vim.opt.incsearch = true         -- incremental search
vim.opt.tabstop = 4              -- number of columns occupied by a tab
vim.opt.softtabstop = 4          -- see multiple spaces as tabstops
vim.opt.expandtab = true         -- converts tabs to white space
vim.opt.shiftwidth = 4           -- width for autoindents
vim.opt.autoindent = true        -- indent a new line like previous line
vim.opt.number = true            -- add line numbers
vim.opt.wildmode = 'longest,list' -- bash-like tab completions
-- vim.opt.colorcolumn = '80'    -- set an 80 column border (commented out)

-- File type and syntax settings
vim.cmd('filetype plugin indent on')  -- allow auto-indenting depending on file type
vim.cmd('syntax on')                  -- enable syntax highlighting

-- System clipboard
vim.opt.clipboard = 'unnamedplus'     -- using system clipboard

-- Performance
vim.opt.ttyfast = true               -- speed up scrolling in Vim

-- Commented out options (original commented settings)
-- vim.opt.spell = true              -- enable spell check
-- vim.opt.swapfile = false          -- disable creating swap file
-- vim.opt.backupdir = '~/.cache/vim' -- directory to store backup files
-- vim.opt.cursorline = true         -- highlight current cursorline

-- Highlight settings
local highlight_groups = {
    'NonText',
    'Normal',
    'NormalNC',
    'SignColumn',
    'Pmenu',
    'FloatBorder',
    'NormalFloat',
    'TabLine'
}

-- Apply transparent background to all highlight groups
for _, group in ipairs(highlight_groups) do
    vim.api.nvim_set_hl(0, group, {
        ctermbg = 'NONE',
        ctermfg = 'NONE',
        bg = 'NONE'
    })
end

vim.keymap.set('i', 'jk', '<ESC>', { noremap = true })
vim.opt.timeoutlen = 200

vim.keymap.set('n', '<leader>c', 'ggVG"+y', { desc = 'Copy buffer to system clipboard' })
vim.keymap.set('n', '<leader>q', ':q!<CR>', { silent = true })

require("lazy").setup("plugins")
