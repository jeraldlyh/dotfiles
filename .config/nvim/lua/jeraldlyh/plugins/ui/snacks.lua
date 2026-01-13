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
    scratch = {
      enabled = true,
    },
    picker = {
      enabled = true,
      matcher = {
        frecency = true,
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
        Snacks.picker.files()
      end,
      desc = "Find files",
    },
    {
      "<leader>fr",
      function()
        Snacks.picker.recent()
      end,
      desc = "Find recent files",
    },
    {
      "<leader>fs",
      function()
        Snacks.picker.grep()
      end,
      desc = "Find string",
    },
    {
      "<leader>fw",
      function()
        Snacks.picker.grep_word()
      end,
      desc = "Find word under cursor",
    },
    {
      "<leader>fc",
      function()
        Snacks.picker.git_log()
      end,
      desc = "Find commits (repo)",
    },
    {
      "<leader>fC",
      function()
        Snacks.picker.git_log_file()
      end,
      desc = "Find commits (file)",
    },
    {
      "<leader>fl",
      function()
        Snacks.picker.git_log_line()
      end,
      desc = "Find commits (line)",
    },
    {
      "<leader>fb",
      function()
        Snacks.picker.buffers()
      end,
      desc = "Find buffers",
    },
    {
      "<leader>fS",
      function()
        Snacks.picker.git_status()
      end,
      desc = "Find git status",
    },
    {
      "<leader>fz",
      function()
        Snacks.picker.smart()
      end,
      desc = "Find smart",
    },
    {
      "<leader>fm",
      function()
        Snacks.picker.command_history()
      end,
      desc = "Find command history",
    },
    {
      "<leader>sp",
      function()
        Snacks.scratch()
      end,
      desc = "Open scratch buffer",
    },
    {
      "<leader>ss",
      function()
        Snacks.scratch.select()
      end,
      desc = "Select scratch buffer",
    },
    {
      "<leader>gg",
      function()
        Snacks.lazygit.open()
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
      desc = "Git copy URL",
    },
    {
      "<leader>go",
      function()
        Snacks.gitbrowse.open()
      end,
      desc = "Git open in browser",
    },
  },
}
