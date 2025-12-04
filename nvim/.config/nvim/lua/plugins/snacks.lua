return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        dashboard = { enabled = true },
        notifier = { enabled = true },
        indent = {
            enabled = true,
            char = "|",
            only_current = false,
            scope = {
                enabled = true,
            },
            hl = "SnacksIndent",
        },
        scroll = { enabled = true },
        statuscolumn = { enabled = true },
        words = { enabled = true },
        lazygit = { enabled = true }
    },
    keys = {
        { "<leader>gg", function() Snacks.lazygit() end, desc = "Open Lazygit" },
    }
}
