return {
  "mistweaverco/kulala.nvim",
  ft = { "http", "rest" },
  tag = "v6.11.0",
  event = { "SessionLoadPost", "VimLeavePre" },
  opts = {
    global_keymaps = true,
    global_keymaps_prefix = "<leader>R",
    kulala_keymaps_prefix = "",
    ui = {
      max_response_size = 1024 * 1024 * 5, -- 5 MB
    },
    kulala_keymaps = {
      ["Show headers and body"] = {
        "A",
        function()
          require("kulala.ui").show_headers_body()
        end,
      },
      ["Show verbose"] = {
        "V",
        function()
          require("kulala.ui").show_verbose()
        end,
      },
      ["Show script output"] = {
        "O",
        function()
          require("kulala.ui").show_script_output()
        end,
      },
      ["Show stats"] = {
        "S",
        function()
          require("kulala.ui").show_stats()
        end,
      },
      ["Show report"] = {
        "R",
        function()
          require("kulala.ui").show_report()
        end,
      },
      ["Show filter"] = {
        "F",
        function()
          require("kulala.ui").toggle_filter()
        end,
      },
      ["Next response"] = {
        "]",
        function()
          require("kulala.ui").show_next()
        end,
        prefix = false,
      },
      ["Previous response"] = {
        "[",
        function()
          require("kulala.ui").show_previous()
        end,
        prefix = false,
      },
      ["Clear responses history"] = {
        "X",
        function()
          require("kulala.ui").clear_responses_history()
        end,
      },
      ["Interrupt requests"] = {
        "<C-c>",
        function()
          require("kulala.ui").interrupt_requests()
        end,
        prefix = false,
      },
      ["Show help"] = {
        "?",
        function()
          require("kulala.ui").show_help()
        end,
        prefix = false,
      },
      ["Close"] = {
        "q",
        function()
          require("kulala.ui").close_kulala_buffer()
        end,
        prefix = false,
      },
    },
  },
}
