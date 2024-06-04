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
