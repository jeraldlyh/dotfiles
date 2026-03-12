return {
  "github/copilot.vim",
  config = function()
    vim.g.copilot_no_tab_map = true
    vim.keymap.set(
      "i",
      "<M-Enter>",
      "copilot#Accept('<CR>')",
      { noremap = true, silent = true, expr = true, replace_keycodes = false }
    )

    if vim.env.COPILOT_PROXY_SERVER then
      vim.g.copilot_proxy_server = vim.env.COPILOT_PROXY_SERVER
      vim.g.copilot_proxy_strict_ssl = true
    end

    local disabled_filetypes = {}
    local disabled_name_patterns = {
      "Credentials.md",
      ".env",
    }

    local function should_disable_copilot(bufnr)
      local ft = vim.bo[bufnr].filetype
      if disabled_filetypes[ft] then
        return true
      end

      local full = vim.api.nvim_buf_get_name(bufnr)
      if full == "" then
        return false
      end

      local fname = vim.fn.fnamemodify(full, ":t")
      for _, pat in ipairs(disabled_name_patterns) do
        if vim.fn.match(fname, pat) ~= -1 then
          return true
        end
      end

      return false
    end

    local group = vim.api.nvim_create_augroup("CopilotFilter", { clear = true })
    vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
      group = group,
      pattern = "*",
      callback = function(args)
        if should_disable_copilot(args.buf) then
          vim.b[args.buf].copilot_enabled = false
          vim.notify("Copilot disabled for: " .. vim.api.nvim_buf_get_name(args.buf))
        end
      end,
    })
  end,
}
