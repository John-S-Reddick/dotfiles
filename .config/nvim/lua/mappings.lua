require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map({ "n", "v" }, "<leader>a", function()
  require("harpoon.mark").add_file()
end, { desc = "Harpoon Add"})

map("n", "<leader>q", function()
  require("harpoon.ui").toggle_quick_menu()
end, { desc = "Harpoon Menu"})

for i = 1, 6 do
  map("n", "<leader>" .. i, function()
    require("harpoon.ui").nav_file(i)
  end)
end
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
