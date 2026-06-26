require("catppuccin").setup {
    transparent_background = true,
    default_integrations = true,
     -- auto_integrations = true,
    integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        notify = false,
        mini = {
            enabled = true,
            indentscope_color = "",
        },
    }
}
vim.cmd('colorscheme catppuccin-macchiato')
