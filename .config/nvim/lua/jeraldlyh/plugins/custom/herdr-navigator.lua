local function navigate(direction)
  local before = vim.fn.winnr()
  vim.cmd("wincmd " .. direction)

  if vim.fn.winnr() == before then
    local herdr_direction = ({ h = "left", j = "down", k = "up", l = "right" })[direction]
    vim.fn.system({ "herdr", "pane", "focus", "--direction", herdr_direction, "--current" })
  end
end

for _, direction in ipairs({ "h", "j", "k", "l" }) do
  vim.keymap.set("n", "<C-" .. direction .. ">", function()
    navigate(direction)
  end, { silent = true, desc = "Navigate split/pane " .. direction })
end
