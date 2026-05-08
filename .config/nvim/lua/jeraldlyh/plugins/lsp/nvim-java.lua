return {
  "nvim-java/nvim-java",
  ft = { "java", "groovy", "kotlin" },
  config = function()
    require("java").setup()
  end,
}
