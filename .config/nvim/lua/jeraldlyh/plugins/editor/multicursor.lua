return {
  "jake-stewart/multicursor.nvim",
  branch = "1.0",
  config = function()
    local multicursor = require("multicursor-nvim")
    local keymap = vim.keymap

    multicursor.setup()

    keymap.set({ "n", "x" }, "<up>", function()
      multicursor.lineAddCursor(-1)
    end)
    keymap.set({ "n", "x" }, "<down>", function()
      multicursor.lineAddCursor(1)
    end)
    keymap.set({ "n", "x" }, "<leader><up>", function()
      multicursor.lineSkipCursor(-1)
    end)
    keymap.set({ "n", "x" }, "<leader><down>", function()
      multicursor.lineSkipCursor(1)
    end)

    keymap.set({ "n", "x" }, "<leader>n", function()
      multicursor.matchAddCursor(1)
    end, { desc = "Add next cursor by matching word/selection" })
    keymap.set({ "n", "x" }, "<leader>s", function()
      multicursor.matchSkipCursor(1)
    end, { desc = "Skip next cursor by matching word/selection" })

    keymap.set(
      { "n", "x" },
      "<leader>N",
      multicursor.matchAllAddCursors,
      { desc = "Add cursors to all matches of word/selection" }
    )
    keymap.set("x", "I", multicursor.insertVisual, { desc = "Insert at the beginning of each cursor line" })
    keymap.set("x", "A", multicursor.appendVisual, { desc = "Append at the end of each cursor line" })

    keymap.set("n", "<c-leftmouse>", multicursor.handleMouse)
    keymap.set("n", "<c-leftdrag>", multicursor.handleMouseDrag)
    keymap.set("n", "<c-leftrelease>", multicursor.handleMouseRelease)

    multicursor.addKeymapLayer(function(layerSet)
      layerSet({ "n", "x" }, "<left>", multicursor.prevCursor, { desc = "Select previous cursor" })
      layerSet({ "n", "x" }, "<right>", multicursor.nextCursor, { desc = "Select next cursor" })
      layerSet({ "n", "x" }, "<leader>x", multicursor.deleteCursor, { desc = "Delete cursor" })
      layerSet("n", "<esc>", function()
        if not multicursor.cursorsEnabled() then
          multicursor.enableCursors()
        else
          multicursor.clearCursors()
        end
      end, { desc = "Exit multi-cursor mode" })
    end)

    local hl = vim.api.nvim_set_hl
    hl(0, "MultiCursorCursor", { reverse = true })
    hl(0, "MultiCursorVisual", { link = "Visual" })
    hl(0, "MultiCursorSign", { link = "SignColumn" })
    hl(0, "MultiCursorMatchPreview", { link = "Search" })
    hl(0, "MultiCursorDisabledCursor", { reverse = true })
    hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
    hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
  end,
}
