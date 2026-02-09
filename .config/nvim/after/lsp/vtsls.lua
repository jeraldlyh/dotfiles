local function create_react_file()
  vim.ui.input({ prompt = "Enter component name: " }, function(name)
    if not name or name == "" then
      return
    end
    local filename = string.lower(name) .. ".tsx"
    local template = string.format(
      [[
import React from "react";

export const %s = () => {
  /* ---------------------------------------------------------- */
  /*                      CONST STATE REF                       */
  /* ---------------------------------------------------------- */

  /* ---------------------------------------------------------- */
  /*                          EFFECTS                           */
  /* ---------------------------------------------------------- */

  /* ---------------------------------------------------------- */
  /*                      HELPER FUNCTIONS                      */
  /* ---------------------------------------------------------- */

  /* ---------------------------------------------------------- */
  /*                           RENDER                           */
  /* ---------------------------------------------------------- */

  return (<div></div>)
};
]],
      name
    )
    local cwd = vim.fn.expand("%:p:h")
    local path = cwd .. "/" .. filename
    local file = io.open(path, "w")
    if file then
      file:write(template)
      file:close()
      vim.cmd("edit " .. path)
    else
      vim.notify("Could not create file: " .. path, vim.log.levels.ERROR)
    end
  end)
end

---@type vim.lsp.Config
return {
  on_attach = function(_, bufnr)
    local function organize_imports()
      vim.lsp.buf.code_action({
        context = { only = { "source.organizeImports" }, diagnostics = {} },
        apply = true,
      })
      vim.lsp.buf.format({ async = true })
    end

    vim.keymap.set("n", "<leader>oi", organize_imports, { desc = "Organize imports", buffer = bufnr })
    vim.keymap.set("n", "<leader>rc", create_react_file, { desc = "Create React file", buffer = bufnr })
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
