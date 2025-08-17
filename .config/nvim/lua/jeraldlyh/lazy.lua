local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { import = "jeraldlyh.plugins" },
  { import = "jeraldlyh.plugins.ai" },
  { import = "jeraldlyh.plugins.editor" },
  { import = "jeraldlyh.plugins.formatter" },
  { import = "jeraldlyh.plugins.git" },
  { import = "jeraldlyh.plugins.lsp" },
  { import = "jeraldlyh.plugins.notes" },
  { import = "jeraldlyh.plugins.ui" },
  { import = "jeraldlyh.plugins.utils" },
  { import = "jeraldlyh.plugins.window" },
}, {
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
})
