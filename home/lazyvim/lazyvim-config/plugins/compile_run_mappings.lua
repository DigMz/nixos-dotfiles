local function open_terminal(cmd)
  vim.cmd("wal")
  local width = math.floor(vim.o.columns * 0.9)
  local height = math.floor(vim.o.lines * 0.8)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)
  local buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
  })
  -- vim.fn.termopen(cmd)
  vim.fn.jobstart(cmd, { term = true })
  vim.cmd("startinsert")
end

vim.keymap.set("n", "<F4>", function()
  open_terminal("make")
end, { desc = "Run make in floating terminal" })

return {}
