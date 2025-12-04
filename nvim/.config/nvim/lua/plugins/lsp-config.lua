return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    -- mason-lspconfig v2+ works with vim.lsp.config / vim.lsp.enable
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
        -- default is automatic_enable = true, so installed servers
        -- are automatically `vim.lsp.enable()`-d
        -- automatic_enable = true,
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- GLOBAL LSP KEYMAPS (same behaviour as before)
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, {})

      -- lua_ls: mark `vim` as a global, same as your old setup()
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      })

      -- ruff: keep your custom on_attach formatting + "Organize Imports"
      vim.lsp.config("ruff", {
        on_attach = function(_, bufnr)
          vim.keymap.set("n", "<leader>f", function()
            vim.lsp.buf.format()
            vim.lsp.buf.code_action({
              filter = function(action)
                return action.title == "Ruff: Organize Imports"
              end,
              apply = true,
            })
          end, { buffer = bufnr })

          -- Auto-fix all failures using pyproject.toml config
          vim.keymap.set("n", "<leader>fd", function()
            local file = vim.api.nvim_buf_get_name(0)
            if file == "" then
              vim.notify("No file name", vim.log.levels.ERROR)
              return
            end

            -- Save the file first
            vim.cmd("write")

            -- Run ruff check --fix on the current file
            local result = vim.fn.system("ruff check --fix " .. vim.fn.shellescape(file))

            -- Reload the buffer to show the fixes
            vim.cmd("edit!")

            if vim.v.shell_error == 0 then
              vim.notify("Ruff: Fixed all auto-fixable issues", vim.log.levels.INFO)
            else
              vim.notify("Ruff: " .. result, vim.log.levels.WARN)
            end
          end, { buffer = bufnr, desc = "Ruff: Auto-fix all failures" })
        end,
      })

      -- terraformls: same custom filetypes & cmd
      vim.lsp.config("terraformls", {
        filetypes = { "terraform", "tf", "terraform-vars" },
        cmd = { "terraform-ls", "serve" },
      })

      -- If you want to be explicit instead of relying on mason-lspconfig's
      -- automatic_enable, uncomment this:
      --
      -- vim.lsp.enable({
      --   "lua_ls",
      --   "clangd",
      --   "ruff",
      --   "tflint",
      --   "zls",
      --   "bashls",
      --   "terraformls",
      -- })
    end,
  },
}

