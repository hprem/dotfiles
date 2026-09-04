require("luasnip").config.setup({
  region_check_events = "CursorHold,InsertLeave",
  delete_check_events = "TextChanged,InsertEnter",
})

-- Optional: Load standard python snippets
require("luasnip.loaders.from_vscode").lazy_load()
