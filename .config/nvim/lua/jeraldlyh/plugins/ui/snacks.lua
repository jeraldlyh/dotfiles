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
    gitbrowse = {
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
      actions = {
        diff_commit = function(picker, item)
          local sha = item and (item.commit or item.hash or item.sha or item.value)
          if type(sha) ~= "string" then
            sha = item and item.text or ""
          end
          sha = sha:match("%x%x%x%x%x%x%x+")
          if not sha then
            return
          end

          picker:close()
          vim.cmd(("CodeDiff %s^ %s"):format(sha, sha))
        end,

        diff_branch = function(picker, item)
          local function current_branch()
            local out = vim.fn.systemlist({ "git", "branch", "--show-current" })
            return (out and out[1] ~= "" and out[1]) or "HEAD"
          end

          local branch = item and (item.branch or item.name or item.text)
          if not branch then
            return
          end
          branch = branch:gsub("^%*%s*", ""):gsub("^%s+", "")

          local base = current_branch()
          picker:close()
          vim.schedule(function()
            vim.cmd(("CodeDiff %s...%s"):format(branch, base))
          end)
        end,
      },
      sources = {
        git_log = {
          confirm = "diff_commit",
        },
        git_branches = {
          confirm = "diff_branch",
          all = true,
        },
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
      "<leader>fB",
      function()
        Snacks.picker.git_branches()
      end,
      desc = "Find branches",
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
      mode = { "x", "n" },
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
