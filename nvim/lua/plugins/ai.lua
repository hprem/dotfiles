-- plugins/ai.lua

local codecompanion = require("codecompanion")

codecompanion.setup({
  -- 1. Configure the adapter to point to your local OpenAI-compatible server
  adapters = {
    openai = function()
      return require("codecompanion.adapters").extend("openai", {
        -- Change this URL to match your local setup
        url = "http://192.168.1.10:8000/v1/chat/completions",
        -- Local servers often don't need a real key, but the adapter requires a string
        api_key = "omlx",
      })
    end,
  },

  -- 2. Set your default local model
  strategies = {
    chat = {
      adapter = "openai",
      model = "Qwen3.6-35B-A3B-oQ6-mtp"
    },
    inline = {
      adapter = "openai",
      model = "Qwen3.6-27B-oQ4-mtp"
    },
  },

  -- 3. Low-CPU UI settings
  display = {
    -- Use Neovim's built-in float for chat (lightweight)
    chat = {
      window = {
        layout = "vertical", -- or "float"
      },
    },
  },
})

-- ==========================================
-- Keybinds
-- ==========================================
vim.keymap.set("n", "<leader>ca", "<cmd>CodeCompanionChat<CR>", { desc = "AI: Open Chat" })
vim.keymap.set("v", "<leader>ce", "<cmd>CodeCompanionChat Edit<CR>", { desc = "AI: Edit Selection in Chat" })

-- INLINE EDIT (The most CPU-efficient way to use AI)
-- Press <leader>ci in visual mode, type your prompt, and it replaces the code inline
vim.keymap.set("v", "<leader>ci", "<cmd>CodeCompanionInline<CR>", { desc = "AI: Inline Edit" })

-- Add current file to chat context quickly
vim.keymap.set("n", "<leader>cf", "<cmd>CodeCompanionChat Add<CR>", { desc = "AI: Add File to Chat" })
