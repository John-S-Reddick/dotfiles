require "nvchad.mappings"

-- add yours here
local function exec_code_run(termargs)
  pcall(function()
    vim.cmd "w"
  end)
  -- Run python script instead even if .nvim-run.sh exists
  if vim.bo.filetype == "python" then
    local current_file = vim.fn.expand "%:p"
    local relative_path = vim.fn.fnamemodify(current_file, ":.:.")
    if vim.fn.filereadable "venv/bin/activate" == 1 then
      vim.cmd('TermExec cmd="source venv/bin/activate" ' .. termargs)
    end

    vim.cmd('TermExec cmd="python ' .. relative_path .. '" ' .. termargs)
  else
    local run_script = "./.nvim-run.sh"
    if vim.fn.filereadable(run_script) == 1 then
      vim.fn.system("chmod +x " .. run_script .. " > /dev/null 2>&1")
      vim.cmd('TermExec cmd="' .. run_script .. '" ' .. termargs)
      return
    else
      local current_ft = vim.bo.filetype
      if current_ft == "rust" then
        vim.cmd.RustLsp { "runnables", bang = true }
      elseif current_ft == "go" then
        local current_file = vim.fn.expand "%:p"
        local relative_path = vim.fn.fnamemodify(current_file, ":.:.")
        vim.cmd('TermExec cmd="go run ' .. relative_path .. '" ' .. termargs)
      else
        vim.print "Saved. No run configs supported for the current directory or filetype."
      end
    end
  end
end
local map = vim.keymap.set

map({"n","v"}, "<leader>o", function()
  local row = vim.api.nvim_win_get_cursor(0)[1]
  vim.api.nvim_buf_set_lines(0, row, row, false, { "" })
  vim.api.nvim_buf_set_lines(0, row - 1, row - 1, false, { "" })
end, { desc = "Add spacing around" })

map("n", "<leader>p", function()
  vim.cmd "normal o"
  local row = vim.api.nvim_win_get_cursor(0)[1]
  vim.api.nvim_buf_set_lines(0, row, row, false, { "" })
  vim.api.nvim_buf_set_lines(0, row - 1, row - 1, false, { "" })
  vim.cmd "normal pk"
end, { desc = "Paste pretty" })

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
map("n", "<F5>", function()
  exec_code_run "direction=float"
end, { desc = "Run Script" })

map("n", "<S-F5>", function()
  exec_code_run "direction=vertical size=80"
end, { desc = "Run Script" })
