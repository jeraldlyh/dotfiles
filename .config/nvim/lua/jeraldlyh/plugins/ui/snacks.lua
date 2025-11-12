return {
  "folke/snacks.nvim",
  lazy = false,
  opts = {
    input = {
      enabled = true,
    },
    bigfile = {
      enabled = true,
    },
    indent = {
      enabled = true,
      animate = {
        enabled = false,
      },
    },
    notifier = {
      enabled = true,
    },
    lazygit = {
      enabled = true,
    },
    gitbrowser = {
      enabled = true,
    },
    picker = {
      enabled = true,
      matcher = {
        recency = true,
      },
      win = {
        input = {
          keys = {
            ["<c-h>"] = { "toggle_hidden", mode = { "i", "n" } },
            ["<c-g>"] = { "toggle_ignored", mode = { "i", "n" } },
            ["<c-r>"] = { "toggle_regex", mode = { "i", "n" } },
            ["<Esc>"] = { "close", mode = { "i", "n" } },
            ["J"] = { "preview_scroll_down", mode = { "i", "n" } },
            ["K"] = { "preview_scroll_up", mode = { "i", "n" } },
            ["H"] = { "preview_scroll_left", mode = { "i", "n" } },
            ["L"] = { "preview_scroll_right", mode = { "i", "n" } },
          },
        },
      },
    },
    image = {
      enabled = true,
      formats = {
        "png",
        "jpg",
        "jpeg",
        "gif",
        "bmp",
        "webp",
        "tiff",
        "heic",
        "avif",
        "mp4",
        "mov",
        "avi",
        "mkv",
        "webm",
        "pdf",
        "icns",
      },
    },
  },
  keys = {
    {
      "<leader>ff",
      function()
        require("snacks").picker.files({
          finder = "files",
          format = "file",
          show_empty = true,
          follow = false,
          supports_live = true,
        })
      end,
      desc = "Find files",
    },
    {
      "<leader>fr",
      function()
        require("snacks").picker.recent()
      end,
      desc = "Find recent files",
    },
    {
      "<leader>fs",
      function()
        require("snacks").picker.grep({
          finder = "grep",
          regex = true,
          format = "file",
          show_empty = true,
          live = true,
          supports_live = true,
        })
      end,
      desc = "Find string",
    },
    {
      "<leader>fw",
      function()
        require("snacks").picker.grep_word({
          finder = "grep",
          regex = false,
          args = { "--word-regexp", "--no-ignore" },
          format = "file",
          search = function(picker)
            return picker:word()
          end,
          live = false,
          supports_live = true,
        })
      end,
      desc = "Find word under cursor",
    },
    {
      "<leader>fc",
      function()
        require("snacks").picker.git_log()
      end,
      desc = "Find commits (repo)",
    },
    {
      "<leader>fC",
      function()
        require("snacks").picker.git_log_file()
      end,
      desc = "Find commits (file)",
    },
    {
      "<leader>fl",
      function()
        require("snacks").picker.git_log_line()
      end,
      desc = "Find commits (line)",
    },
    {
      "<leader>fb",
      function()
        require("snacks").picker.buffers()
      end,
      desc = "Find buffers",
    },
    {
      "<leader>fS",
      function()
        require("snacks").picker.git_status()
      end,
      desc = "Find git status",
    },
    {
      "<leader>gg",
      function()
        require("snacks").lazygit.open()
      end,
      desc = "Open Lazy git",
    },
    {
      "<leader>gy",
      function()
        Snacks.gitbrowse({
          open = function(url)
            vim.fn.setreg("+", url)
          end,
          notify = false,
        })
      end,
      { desc = "Git copy URL" },
    },
  },
}
