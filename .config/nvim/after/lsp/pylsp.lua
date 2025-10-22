return {
  settings = {
    pylsp = {
      signature = {
        formatter = "ruff",
      },
      plugins = {
        autopep8 = { enabled = false },
        flake8 = { enabled = false },
        mccabe = { enabled = false },
        pycodestyle = { enabled = false },
        pylint = { enabled = false },
        pyflakes = { enabled = false },
        yapf = { enabled = false },
        black = { enabled = false },
      },
    },
  },
}
