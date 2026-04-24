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
      top_down = false,
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
        git_log_file = {
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
        require("snacks").picker.files()
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
      "<leader>fR",
      function()
        require("snacks").picker.resume()
      end,
      desc = "Find resume previous search",
    },
    {
      "<leader>fs",
      function()
        require("snacks").picker.grep()
      end,
      desc = "Find string",
    },
    {
      "<leader>fw",
      function()
        require("snacks").picker.grep_word()
      end,
      desc = "Find word under cursor",
      mode = { "n" },
    },
    {
      "<leader>fw",
      function()
        local mode = vim.fn.mode()
        local start_pos = vim.fn.getpos("v")
        local end_pos = vim.fn.getpos(".")
        local lines

        if mode == "V" then
          local start_line = math.min(start_pos[2], end_pos[2])
          local end_line = math.max(start_pos[2], end_pos[2])
          lines = vim.fn.getline(start_line, end_line)
        else
          lines = vim.fn.getregion(start_pos, end_pos)
        end

        local text = table.concat(lines, "\n")
        local escaped = vim.fn.escape(text, [[\.^$*+?()[]{}|/-]])

        require("snacks").picker.grep({
          search = escaped,
          hidden = true,
        })
      end,
      desc = "Find word under cursor",
      mode = { "x" },
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
      "<leader>fB",
      function()
        require("snacks").picker.git_branches()
      end,
      desc = "Find branches",
    },

    {
      "<leader>fS",
      function()
        require("snacks").picker.git_status()
      end,
      desc = "Find git status",
    },
    {
      "<leader>fz",
      function()
        require("snacks").picker.smart()
      end,
      desc = "Find smart",
    },
    {
      "<leader>fd",
      function()
        require("snacks").picker.smart({
          hidden = true,
          confirm = function(picker, item)
            picker:close()
            vim.schedule(function()
              local current = vim.api.nvim_buf_get_name(0)
              if current == "" or not item then
                return
              end

              vim.cmd(
                ("CodeDiff file %s %s"):format(
                  vim.fn.fnameescape(current),
                  vim.fn.fnameescape(item.file or item.path or item.value or "")
                )
              )
            end)
          end,
        })
      end,
      desc = "Find file to diff",
    },
    {
      "<leader>sp",
      function()
        require("snacks").scratch()
      end,
      desc = "Open scratch buffer",
    },
    {
      "<leader>ss",
      function()
        require("snacks").scratch.select()
      end,
      desc = "Select scratch buffer",
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
        require("snacks").gitbrowse({
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
        require("snacks").gitbrowse.open()
      end,
      desc = "Git open in browser",
    },
  },
}
