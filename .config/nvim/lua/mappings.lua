require "nvchad.mappings"

-- add yours here
local function GetDiagnostic()
  local bufnr = vim.api.nvim_get_current_buf()
  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  local cursor_line = cursor_pos[1] - 1
  local diagnostics = vim.diagnostic.get(bufnr, { lnum = cursor_line })

  if #diagnostics == 0 then
    vim.print "No diagnostic found"
    return nil
  end

  vim.cmd "normal yy"
  local diag_text = "Diagnostics:\n"
  for _, diag in ipairs(diagnostics) do
    diag_text = diag_text .. diag.message .. "\n"
  end
  local current_line = vim.fn.getreg "*"
  current_line = current_line:sub(1, -2)

  return {
    line = current_line,
    diagnostics = diag_text,
  }
end

local function VFit()
 local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local max_width = 0
  for _, line in ipairs(lines) do
    local width = vim.fn.strdisplaywidth(line)
    if width > max_width then
      max_width = width
    end
  end
  vim.cmd("vertical resize " .. max_width + 6)
end

local function HFit()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local max_height = #lines
  vim.cmd("resize " .. max_height + 1)
end

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
      elseif current_ft == "tex" then
        local current_file = vim.fn.expand "%:p"
        local relative_path = vim.fn.fnamemodify(current_file, ":.:.")
        vim.cmd('silent ! pdflatex ' .. relative_path)
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
--map("t", "<Esc>", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
map("n", "<F5>", function()
  exec_code_run "direction=float"
end, { desc = "Run Script" })

map("n", "<S-F5>", function()
  exec_code_run "direction=vertical size=80"
end, { desc = "Run Script" })

map("n", "<Esc>", function()
  if
    (vim.bo.buftype == "nofile" and vim.bo.filetype == "markdown") -- Inside LSP Hover
    or vim.bo.filetype == "oil" -- Oil
  then
    vim.cmd "q"
  elseif vim.bo.buftype == "terminal" then -- NTERMINAL
    -- Force close terminal on double-esc
    -- First Esc to nterminal mode, second closes:
    vim.cmd "startinsert"
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-c><C-d>", true, true, true), "i", false)
  else
    vim.cmd "noh"
  end
end)

map("n", "<leader>gg", function()
  pcall(function()
    vim.cmd "w"
  end)
  vim.cmd "LazyGit"
end, { desc = "LazyGit" })


map("t", "<Esc>", function()
  if vim.bo.filetype == "lazygit" then
    vim.cmd "q"
  else
    vim.cmd "stopinsert"
  end
end, { desc = "Terminal Escape terminal mode" })
map(
  { "n" },
  "<leader>t",
  "<cmd>ToggleTerm direction=float<CR>",
  { desc = "Terminal Toggle Floating term" }
)

map(
  "n",
  "<leader>v",
  "<cmd>ToggleTerm direction=vertical<CR>",
  { desc = "Terminal Toggle Vertical" }
)
map(
  "n",
  "<leader>h",
  "<cmd>ToggleTerm direction=horizontal<CR>",
  { desc = "Terminal Toggle Horizontal" }
)

-- Harpoon Mappings
map({ "n", "v" }, "<leader>a", function()
  require("harpoon.mark").add_file()
end, { desc = "Harpoon Add" })

map("n", "<leader>q", function()
  require("harpoon.ui").toggle_quick_menu()
end, { desc = "Harpoon Menu" })

for i = 1, 6 do
  map("n", "<leader>" .. i, function()
    require("harpoon.ui").nav_file(i)
  end)

  map("n", "<leader>" .. ({ "!", "@", "#", "$", "%", "^" })[i], function()
    -- auto determine based on aspect ratio
    if (vim.o.columns / vim.o.lines) > 2.4 then
      vim.cmd "vnew"
      require("harpoon.ui").nav_file(i)
      VFit()
    else
      vim.cmd "new"
      require("harpoon.ui").nav_file(i)
      HFit()
    end
  end)
end
map({ "n", "x" }, "<leader>sr", function() require("ssr").open() end)
map({ "n", "v" }, "<leader>d", '"_d', { desc = "d (no copy)"})
map("n", "<leader>lf", function()
  vim.diagnostic.open_float(nil, { border = "rounded" })
end, { desc = "Lsp floating diagnostics" })
map("n", "<C-a>", "<cmd>%y+<CR>", { desc = "File Copy whole" })
map("n", "<leader>ll", function()
  local diag_info = GetDiagnostic()
  if diag_info then
    vim.fn.setreg("*", "Line: `" .. diag_info.line .. "`\n" .. diag_info.diagnostics)
  end
end, { desc = "Copy diagnostics" })


map("n", "<Tab>", "V>ll", { desc = "Indent line" })
map("n", "<S-Tab>", "V<hh", { desc = "De-indent line" })

map("v", "<Tab>", ">llgv", { desc = "Indent line" })
map("v", "<S-Tab>", "<hhgv", { desc = "De-indent line" })

