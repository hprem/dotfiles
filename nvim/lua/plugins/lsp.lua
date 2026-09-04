-- plugins/lsp.lua

-- Configure Astral's 'ty' Language Server
vim.lsp.config.ty = {
  -- The command to start the server. 
  -- (If the docs say to use a specific subcommand like 'ty lsp', change this to { "ty", "lsp" })
  cmd = { "ty" }, 
  
  filetypes = { "python" },
  
  -- Tell Neovim where the root of your Python project is
  root_dir = function(bufnr)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    -- vim.fs.root searches upward from the file to find the first matching directory
    return vim.fs.root(fname, { "pyproject.toml", "ruff.toml", ".git" })
  end,

  -- Because ty is written in Rust, it handles semantic tokens efficiently.
  -- However, if you still prefer Treesitter for highlighting and want to save 
  -- a few extra CPU cycles, you can uncomment the block below:
  --
  -- handlers = {
  --   ["textDocument/semanticTokens"] = vim.schedule_wrap(function()
  --     return { data = {} }
  --   end),
  -- },

  settings = {
    -- Pass any specific ty configuration options here
    -- (Refer to https://docs.astral.sh/ty/features/language-server/ for available settings)
    ty = {
      -- Example: if you need to specify a target python version
      -- targetVersion = "3.12",
    },
  },
}

-- Enable the server
vim.lsp.enable('ty')

-- ==========================================
-- LSP Keybinds (Attached to 'ty')
-- ==========================================
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    
    -- Attach keybinds specifically when 'ty' connects
    if client and client.name == 'ty' then
      local opts = { buffer = args.buf }
      
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, vim.tbl_extend('force', opts, { desc = 'Show Documentation' }))
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, vim.tbl_extend('force', opts, { desc = 'Go to Definition' }))
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, vim.tbl_extend('force', opts, { desc = 'Go to References' }))
      
      -- If ty handles formatting (like Ruff does), map a format key
      if client.server_capabilities.documentFormattingProvider then
        vim.keymap.set('n', '<leader>f', function()
          vim.lsp.buf.format({ async = true })
        end, vim.tbl_extend('force', opts, { desc = 'Format Python (ty)' }))
      end
    end
  end,
})
