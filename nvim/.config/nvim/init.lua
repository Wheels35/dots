-- Bootstrap lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Install Catppuccin theme
require("lazy").setup({
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
      })
      vim.cmd.colorscheme "catppuccin"
    end,
  },
})

-- Basic settings
vim.opt.number = true
vim.opt.mouse = 'a'
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.wrap = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- Custom statusline with nano hints
vim.opt.laststatus = 2
vim.opt.statusline = " ^G Help (:h) │ ^O Save (:w) │ ^X Exit (:q) │ ^W Search (/) │ ^K Cut (dd) │ ^U Paste (p) │ ^C Pos (^G)"

-- Nano-style keybindings
local map = vim.keymap.set

-- Ctrl+O to save
map('n', '<C-o>', ':w<CR>', { desc = 'Save file' })
map('i', '<C-o>', '<Esc>:w<CR>a', { desc = 'Save file' })

-- Ctrl+X to exit (with save prompt)
map('n', '<C-x>', function()
  if vim.bo.modified then
    local choice = vim.fn.confirm("Save changes?", "&Yes\n&No\n&Cancel", 1)
    if choice == 1 then
      vim.cmd('wq')
    elseif choice == 2 then
      vim.cmd('q!')
    end
    -- Cancel = do nothing
  else
    vim.cmd('q')
  end
end, { desc = 'Exit' })

map('i', '<C-x>', function()
  vim.cmd('stopinsert')
  if vim.bo.modified then
    local choice = vim.fn.confirm("Save changes?", "&Yes\n&No\n&Cancel", 1)
    if choice == 1 then
      vim.cmd('wq')
    elseif choice == 2 then
      vim.cmd('q!')
    end
  else
    vim.cmd('q')
  end
end, { desc = 'Exit' })

-- Ctrl+W to search
map('n', '<C-w>', '/', { desc = 'Search' })
map('i', '<C-w>', '<Esc>/', { desc = 'Search' })

-- Ctrl+K to cut line
map('n', '<C-k>', 'dd', { desc = 'Cut line' })
map('i', '<C-k>', '<Esc>dda', { desc = 'Cut line' })

-- Ctrl+U to paste
map('n', '<C-u>', 'p', { desc = 'Paste' })
map('i', '<C-u>', '<Esc>pa', { desc = 'Paste' })

-- Ctrl+G for help
map('n', '<C-g>', ':help<CR>', { desc = 'Help' })
map('i', '<C-g>', '<Esc>:help<CR>', { desc = 'Help' })

-- Ctrl+C to show cursor position
map('n', '<C-c>', '<C-g>', { desc = 'Cursor position' })
map('i', '<C-c>', '<Esc><C-g>a', { desc = 'Cursor position' })

-- Ctrl+\ to go to command mode
map('n', '<C-\\>', ':', { desc = 'Command mode' })

vim.opt.whichwrap:append("<,>,[,]")
