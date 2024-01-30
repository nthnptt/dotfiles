return {
  "ccaglak/namespace.nvim",
  keys = {
    { "<leader>la", "<cmd>GetClasses<cr>" },
    { "<leader>lc", "<cmd>GetClass<cr>" },
    { "<leader>ls", "<cmd>ClassAs<cr>" },
    { "<leader>ln", "<cmd>Namespace<cr>" },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
}
