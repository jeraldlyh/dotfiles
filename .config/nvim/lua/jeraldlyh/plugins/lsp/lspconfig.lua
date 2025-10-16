return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    "williamboman/mason.nvim",
  },
  config = function()
    local mason_lspconfig = require("mason-lspconfig")
    local keymap = vim.keymap

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }

        opts.desc = "Show LSP references"
        keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

        opts.desc = "Go to declaration"
        keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

        opts.desc = "Show LSP definitions"
        keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

        opts.desc = "Show LSP implementations"
        keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

        opts.desc = "Show LSP type definitions"
        keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

        opts.desc = "See available code actions"
        keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

        opts.desc = "Rename symbol"
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

        opts.desc = "Go to previous problem"
        keymap.set("n", "g1", vim.diagnostic.goto_prev, opts)

        opts.desc = "Go to next problem"
        keymap.set("n", "g2", vim.diagnostic.goto_next, opts)

        opts.desc = "Show documentation for what is under cursor"
        keymap.set("n", "K", vim.lsp.buf.hover, opts)

        opts.desc = "Restart LSP"
        keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
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

    mason_lspconfig.setup({
      automatic_installation = true,
      automatic_enable = false,
      ensure_installed = {
        "bashls",
        "cssls",
        "dockerls",
        "docker_compose_language_service",
        "eslint",
        "helm_ls",
        "html",
        "lua_ls",
        "ruff",
        "pylsp",
        "stylua",
        "tailwindcss",
        "vtsls",
      },
    })

    vim.lsp.config.pylsp = {
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
    vim.lsp.enable("pylsp")

    vim.lsp.config.ruff = {
      init_options = {
        settings = {
          lineLength = 100,
          fixAll = true,
          organizeImports = true,
          lint = { enabled = false },
          format = {
            ["quote-style"] = "single",
          },
        },
      },
    }
    vim.lsp.enable("ruff")

    vim.lsp.config.vtsls = {
      on_attach = function(_, bufnr)
        local function organize_imports()
          vim.lsp.buf.code_action({
            context = { only = { "source.organizeImports" }, diagnostics = {} },
            apply = true,
          })
          vim.lsp.buf.format({ async = true })
        end

        keymap.set("n", "<leader>oi", organize_imports, { desc = "Organize imports", buffer = bufnr })
      end,
      settings = {
        typescript = {
          inlayHints = {
            enumMemberValues = { enabled = true },
            functionLikeReturnTypes = { enabled = true },
            parameterNames = { enabled = "literals" },
            parameterTypes = { enabled = true },
            propertyDeclarationTypes = { enabled = true },
            variableTypes = { enabled = true },
          },
          format = {
            convertTabsToSpaces = true,
            indentSize = 2,
            tabSize = 2,
          },
        },
        javascript = {
          inlayHints = {
            enumMemberValues = { enabled = true },
            functionLikeReturnTypes = { enabled = true },
            parameterNames = { enabled = "literals" },
            parameterTypes = { enabled = true },
            propertyDeclarationTypes = { enabled = true },
            variableTypes = { enabled = true },
          },
          format = {
            convertTabsToSpaces = true,
            indentSize = 2,
            tabSize = 2,
          },
        },
      },
    }
    vim.lsp.enable("vtsls")

    vim.lsp.enable({
      "ts_ls",
      "bashls",
      "cssls",
      "dockerls",
      "docker_compose_language_service",
      "eslint",
      "helm_ls",
      "html",
      "lua_ls",
      "stylua",
      "tailwindcss",
    })
  end,
}
