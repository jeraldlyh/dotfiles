return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "saghen/blink.cmp",
    "folke/snacks.nvim",
    { "antosha417/nvim-lsp-file-operations", config = true },
    "williamboman/mason.nvim",
  },
  config = function()
    local mason_lspconfig = require("mason-lspconfig")
    local snacks = require("snacks")
    local keymap = vim.keymap

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local custom_opts = { buffer = ev.buf, silent = true }

        custom_opts.desc = "Show LSP references"
        keymap.set("n", "gR", function()
          snacks.picker.lsp_references()
        end, custom_opts)

        custom_opts.desc = "Go to declaration"
        keymap.set("n", "gD", vim.lsp.buf.declaration, custom_opts)

        custom_opts.desc = "Show LSP definitions"
        keymap.set("n", "gd", function()
          snacks.picker.lsp_definitions()
        end, custom_opts)

        custom_opts.desc = "Show LSP implementations"
        keymap.set("n", "gi", function()
          snacks.picker.lsp_implementations()
        end, custom_opts)

        custom_opts.desc = "Show LSP type definitions"
        keymap.set("n", "gt", function()
          snacks.picker.lsp_type_definitions()
        end, custom_opts)

        custom_opts.desc = "See available code actions"
        keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, custom_opts)

        custom_opts.desc = "Rename symbol"
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, custom_opts)

        custom_opts.desc = "Go to previous problem"
        keymap.set("n", "g1", vim.diagnostic.goto_prev, custom_opts)

        custom_opts.desc = "Go to next problem"
        keymap.set("n", "g2", vim.diagnostic.goto_next, custom_opts)

        custom_opts.desc = "Show documentation for what is under cursor"
        keymap.set("n", "K", vim.lsp.buf.hover, custom_opts)

        custom_opts.desc = "Restart LSP"
        keymap.set("n", "<leader>rs", ":LspRestart<CR>", custom_opts)
      end,
    })

    -- NOTE: Workaround for keymaps not restoring after closing diff view
    --      https://github.com/esmuellert/codediff.nvim/issues/289
    vim.api.nvim_create_autocmd("User", {
      pattern = "CodeDiffClose",
      callback = function(event)
        vim.keymap.set(
          "n",
          "K",
          vim.lsp.buf.hover,
          { buffer = event.buf, silent = true, desc = "Show documentation for what is under cursor" }
        )
      end,
    })

    vim.diagnostic.config({
      virtual_text = true,
      update_in_insert = false,
      underline = true,
      severity_sort = true,
      float = {
        focusable = true,
        style = "minimal",
        border = "rounded",
        source = true,
        header = "",
        prefix = "",
      },
      signs = {
        text = {
          [vim.diagnostic.severity.HINT] = " ",
          [vim.diagnostic.severity.INFO] = " ",
          [vim.diagnostic.severity.WARN] = " ",
          [vim.diagnostic.severity.ERROR] = " ",
        },
      },
    })

    local lsp = {
      "bashls",
      "cssls",
      "dockerls",
      "docker_compose_language_service",
      "eslint",
      "jdtls",
      "html",
      "lua_ls",
      "ruff",
      "basedpyright",
      "stylua",
      "tailwindcss",
      "vtsls",
      "yamlls",
      "kotlin_language_server",
    }

    mason_lspconfig.setup({
      automatic_installation = true,
      automatic_enable = false,
      ensure_installed = lsp,
    })

    vim.lsp.enable(lsp)
    vim.lsp.config("*", {
      capabilities = require("blink.cmp").get_lsp_capabilities(),
    })
  end,
}
