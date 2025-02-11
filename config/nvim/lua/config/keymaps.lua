-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = LazyVim.safe_keymap_set
map("n", "<leader>w", "<cmd>w<cr><esc>")

-- Lets try without mapping ; to : and see how it goes..
-- map("", ";", ":")

-- navigating VSCode tabs
if vim.g.vscode then
  local opts = { noremap = true, silent = true }

  map("", "<C-h>", '<Cmd>lua WinMove("Left")<CR>', opts)
  map("", "<C-j>", '<Cmd>lua WinMove("Down")<CR>', opts)
  map("", "<C-k>", '<Cmd>lua WinMove("Up")<CR>', opts)
  map("", "<C-l>", '<Cmd>lua WinMove("Right")<CR>', opts)

  function WinMove(direction)
    vim.fn.VSCodeCall("workbench.action.focus" .. direction .. "Group")
  end
end

map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected up" })

-- keep cursor at beginning of line when joining lines
map("n", "J", "mzJ`z", { desc = "Squash line up" })

-- keep cursor in center when half page scrolling
map("n", "<C-d>", "<C-d>zz", { desc = "Half page down" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half page up" })

-- keep cursor in center when jumping to next match
map("n", "n", "nzzzv", { desc = "Jump to next match" })
map("n", "N", "Nzzzv", { desc = "Jump to previous match" })

-- delete to black hole register
map("n", "<leader>d", '"_d', { desc = "Delete to black hole register" })
map("v", "<leader>d", '"_d', { desc = "Delete to black hole register" })
