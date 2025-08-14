local chat_history_dir = vim.fn.expand("~/iCloud/ai/copilot-chat")

local function read_prompt_file(filename)
  local config_dir = tostring(vim.fn.stdpath("config"))
  local prompt_dir = vim.fs.joinpath(config_dir, "prompts")
  local file_path = vim.fs.joinpath(prompt_dir, string.format("%s.md", string.lower(filename)))

  if not vim.fn.filereadable(file_path) then
    return ""
  end
  return table.concat(vim.fn.readfile(file_path), "\n")
end

local function save_chat(response)
  local copilot = require("CopilotChat")

  if vim.g.copilot_chat_title then
    copilot.save(vim.g.copilot_chat_title)
    return
  end

  local prompt = read_prompt_file("ChatTitle")

  copilot.ask(vim.trim(prompt:format(response)), {
    callback = function(gen_response)
      local timestamp = os.date("%Y%m%d-%H%M%S")

      local safe_title = vim.base64.encode(gen_response):gsub("/", "_"):gsub("+", "-"):gsub("=", "")
      vim.g.copilot_chat_title = timestamp .. "_" .. vim.trim(safe_title)
      copilot.save(vim.g.copilot_chat_title)

      return gen_response
    end,
    headless = true,
  })
end

local function reset_chat()
  -- local copilot = require("CopilotChat")
  --
  -- copilot.save(vim.g.copilot_chat_title)
  -- copilot.reset()

  vim.g.copilot_chat_title = nil
end

local function load_prompts(prompt_dir)
  local prompts = {}
  local prompt_files = vim.fn.glob(prompt_dir .. "/*.md", false, true)

  for _, file_path in ipairs(prompt_files) do
    local basename = vim.fn.fnamemodify(file_path, ":t:r")
    prompts[basename] = read_prompt_file(basename)
  end

  return prompts
end

local function decode_base64_urlsafe(encoded_title)
  local timestamp, encoded = encoded_title:match("^(%d%d%d%d%d%d%d%d%-%d%d%d%d%d%d)_(.+)")

  if not timestamp or not encoded then
    return "Invalid filename format"
  end

  local padding_len = 4 - (#encoded % 4)

  if padding_len < 4 then
    encoded = encoded .. string.rep("=", padding_len)
  end

  encoded = encoded:gsub("_", "/"):gsub("-", "+")

  local success, decoded = pcall(vim.base64.decode, encoded)

  if success and timestamp then
    return decoded
  else
    return "Failed to decode: " .. encoded_title
  end
end

local function list_chat_history()
  local telescope = require("telescope.builtin")

  telescope.find_files({
    prompt_title = "Copilot Chat History",
    cwd = chat_history_dir,
    hidden = true,
    attach_mappings = function(_, map)
      map("i", "<CR>", function(prompt_bufnr)
        local entry = require("telescope.actions.state").get_selected_entry()

        require("telescope.actions").close(prompt_bufnr)
        vim.cmd("edit " .. chat_history_dir .. "/" .. entry.value)
      end)

      return true
    end,
    entry_maker = function(entry)
      if not entry then
        return nil
      end

      local filename = vim.fn.fnamemodify(entry, ":t")

      if not filename:match("%.json$") then
        return nil
      end

      local filename_no_ext = filename:match("^(.*)%.json$") or filename
      local decoded_title = decode_base64_urlsafe(filename_no_ext)

      if decoded_title == "Invalid filename format" then
        decoded_title = filename
      end

      local mtime = vim.fn.getftime(chat_history_dir .. "/" .. filename)
      local date = ""

      if mtime > 0 then
        date = vim.fn.strftime("%Y-%m-%d %H:%M:%S", mtime)
      else
        date = "Invalid date"
      end

      return {
        value = entry,
        display = string.format("[%s]: %s", date, decoded_title),
        ordinal = decoded_title,
        path = chat_history_dir .. "/" .. filename,
        mtime = mtime,
      }
    end,
    sorter = require("telescope.sorters").Sorter:new({
      scoring_function = function(_, entryOne, entryTwo)
        local mtimeOne = entryOne.mtime or 0
        local mtimeTwo = entryTwo.mtime or 0
        return mtimeOne - mtimeTwo
      end,
    }),
    previewer = require("telescope.previewers").new_buffer_previewer({
      define_preview = function(self, entry)
        if vim.fn.filereadable(entry.path) == 1 then
          local content = vim.fn.readfile(entry.path)

          if vim.fn.fnamemodify(entry.path, ":e") == "json" then
            local ok, json = pcall(vim.fn.json_decode, table.concat(content, "\n"))
            if ok then
              content = vim.fn.split(vim.fn.json_encode(json), "\n")
            end
          end

          vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, content)
          vim.bo[self.state.bufnr].filetype = "json"
        else
          vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, { "File not found or unreadable: " .. entry.path })
        end
      end,
    }),
  })
end

return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim", branch = "master" },
      "github/copilot.vim",
      "nvim-telescope/telescope.nvim",
      "MeanderingProgrammer/render-markdown.nvim",
    },
    build = "make tiktoken",
    enabled = false,
    config = function()
      local copilot = require("CopilotChat")
      local keymap = vim.keymap

      copilot.setup({
        log_level = "warn",
        history_path = chat_history_dir,
        prompts = load_prompts(vim.fn.stdpath("config") .. "/prompts"),
        selection = false, -- Have no predefined context by default
        mappings = {
          complete = { insert = "<S-Tab>" },
          reset = {
            insert = "<C-l>",
            normal = "<C-l>",
            callback = reset_chat,
          },
          show_diff = {
            full_diff = true,
          },
        },
        callback = save_chat,
      })

      -- keymap.set("n", "<leader>co", copilot.open, { desc = "Open Copilot chat" })
      -- keymap.set("n", "<leader>cr", reset_chat, { desc = "Reset Copilot chat" })
      -- keymap.set("n", "<leader>cm", copilot.select_model, { desc = "Select Copilot models" })
      -- keymap.set("n", "<leader>cp", copilot.select_prompt, { desc = "Select Copilot prompts" })
      -- keymap.set("n", "<leader>ch", list_chat_history, { desc = "Show Copilot chat history" })
    end,
  },
}
