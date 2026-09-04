-- blink for code completion
-- Download https://github.com/saghen/blink.cmp/releases/download/v1.10.2/x86_64-unknown-linux-gnu.so and place it under
-- ~/.local/share/nvim/site/pack/plugins/start/blink.cmp/lib/libblink_cmp_fuzzy.so 
require("blink.cmp").setup({
  -- CONSTRAINT 1: Enable ONLY for Python
  enabled = function()
    local ft = vim.bo.filetype
    return ft == "python" or ft == ""
  end,

  -- CONSTRAINT 2 & 3: Tab key mapping
  keymap = {
    ["<Tab>"] = { "snippet_forward", "accept", "fallback" },
    ["<S-Tab>"] = { "snippet_backward", "fallback" },
    ["<CR>"] = { "fallback" },
    ["<Up>"] = { "show_documentation", "scroll_documentation_up", "fallback" },
    ["<Down>"] = { "scroll_documentation_down", "fallback" },
  },

  -- Tell blink to use LuaSnip
  snippets = { 
    expand = function(snippet) 
      require("luasnip").lsp_expand(snippet) 
    end 
  },

  sources = {
    default = { "lsp", "snippets", "path", "buffer" },
  },

  -- Performance tweaks
  completion = {
    documentation = { auto_show = false },
    menu = {
      draw = {
        treesitter = { "lsp" }, 
      },
    },
  },

  fuzzy = { implementation = "prefer_rust_with_warning" },
})
