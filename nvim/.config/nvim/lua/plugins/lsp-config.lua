return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "clangd",
                    "ruff",
                    "tflint",
                    "zls",
                    "terraformls",
                },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            ----------------------------------------------------------------------
            -- Global LSP keymaps
            ----------------------------------------------------------------------
            vim.keymap.set("n", "K",  vim.lsp.buf.hover, {})
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
            vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, {})

            ----------------------------------------------------------------------
            -- lua_ls
            ----------------------------------------------------------------------
            vim.lsp.config("lua_ls", {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                    },
                },
            })

            ----------------------------------------------------------------------
            -- Ruff
            ----------------------------------------------------------------------
            vim.lsp.config("ruff", {
                -- Rough equivalent of util.root_pattern("pyproject.toml", ".git")
                root_markers = { "pyproject.toml", ".git" },

                on_attach = function(_, bufnr)
                    vim.keymap.set("n", "<leader>r", function()
                        vim.lsp.buf.code_action({
                            filter = function(a)
                                return a.kind == "source.fixAll.ruff"
                            end,
                            apply = true,
                        })
                    end, { buffer = bufnr, desc = "Ruff: Fix all" })

                    vim.keymap.set("n", "<leader>F", function()
                        vim.lsp.buf.format({ name = "ruff", async = false })
                    end, { buffer = bufnr, desc = "Ruff: Format file" })
                end,
            })

            ----------------------------------------------------------------------
            -- terraformls
            ----------------------------------------------------------------------
            vim.lsp.config("terraformls", {
                filetypes = { "terraform", "tf", "terraform-vars" },
                cmd = { "terraform-ls", "serve" },
            })

            ----------------------------------------------------------------------
            -- Enable servers
            ----------------------------------------------------------------------
            local servers = {
                "lua_ls",
                "clangd",
                "ruff",
                "terraformls",
                "tflint",
                "zls",
            }

            for _, name in ipairs(servers) do
                -- pcall so a missing server doesn't throw at startup
                pcall(vim.lsp.enable, name)
            end
        end,
    },
}
