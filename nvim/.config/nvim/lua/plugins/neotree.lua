return {
    'nvim-neo-tree/neo-tree.nvim',
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
        "s1n7ax/nvim-window-picker",
    },
    keys = {
        { '<C-n>', ':Neotree toggle<CR>' },
        { '<C-e>', ':Neotree focus<CR>' },
        { '<leader>e', ':Neotree reveal<CR>' },
        { '<leader>w', '<C-w>w' },
    }
}
