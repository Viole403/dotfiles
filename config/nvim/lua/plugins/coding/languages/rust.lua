-- plugins/coding/languages/rust.lua
return {
  "simrat39/rust-tools.nvim",
  ft = "rust",
  dependencies = "neovim/nvim-lspconfig",
  config = function()
    local rt = require("rust-tools")
    local lsp = require("plugins.coding.lsp")

    -- rust-tools handles both LSP and additional Rust features
    -- No need for separate lsp/rust.lua
    rt.setup({
      server = {
        capabilities = lsp.common.capabilities,
        on_attach = function(client, bufnr)
          lsp.common.on_attach(client, bufnr)

          -- Rust-specific keybindings
          vim.keymap.set("n", "<leader>rr", rt.runnables.runnables, { buffer = bufnr, desc = "Rust runnables" })
          vim.keymap.set("n", "<leader>rd", rt.debuggables.debuggables, { buffer = bufnr, desc = "Rust debuggables" })
          vim.keymap.set("n", "K", rt.hover_actions.hover_actions, { buffer = bufnr, desc = "Hover actions" })
          vim.keymap.set("n", "<leader>ca", rt.code_action_group.code_action_group, { buffer = bufnr, desc = "Code actions" })
        end,
        settings = {
          ["rust-analyzer"] = {
            cargo = { allFeatures = true },
            checkOnSave = { command = "clippy" },
          },
        },
      },
      tools = {
        hover_actions = {
          auto_focus = true,
        },
        inlay_hints = {
          auto = true,
          show_parameter_hints = true,
        },
      },
    })

    -- Format on save with rustfmt (built into rust-analyzer)
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*.rs",
      callback = function()
        vim.lsp.buf.format({ async = false })
      end,
    })
  end,
}
