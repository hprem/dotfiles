-- plugins/neogen.lua
-- For Docstring Generation
require("neogen").setup({
  languages = {
    -- python = { template = { annotation_convention = "reST" } },   -- sphinx style
    python = { template = { annotation_convention = "google_docstrings" } },
  },
  snippet_engine = "luasnip",
})

vim.keymap.set("n", "<leader>dg", function()
  require("neogen").generate({ type = "func" })
end, { desc = "Generate [C]ode [D]ocstring" })
