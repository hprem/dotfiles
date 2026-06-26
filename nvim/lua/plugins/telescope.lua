-- Telescope Config & Customizations
local telescope = require('telescope')
local actions = require('telescope.actions')

telescope.setup({
  defaults = {
    -- Standard config
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--hidden'
    },
    prompt_prefix = "🔍 ",
    selection_caret = " ",
    path_display = { "truncate" },

    -- Keybinds
    mappings = {
      i = {
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-c>"] = actions.close,
      },
    },
  },
  pickers = {
    find_files = {
      theme = "dropdown",
      -- search_dirs = { '~/'},
      hidden = true,
    },
  },
  extensions = {
    -- Hier können Erweiterungen hinzugefügt werden, falls nötig
  },
})

