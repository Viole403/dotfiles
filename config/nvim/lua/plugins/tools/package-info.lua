-- plugins/tools/package-info.lua
return {
  "vuki656/package-info.nvim",
  dependencies = { "MunifTanjim/nui.nvim" },
  ft = "json",
  config = function()
    require("package-info").setup({
      colors = {
        up_to_date = "#3C4048",
        outdated = "#d19a66",
      },
    })

    vim.keymap.set("n", "<leader>nu", require("package-info").update, { desc = "Update package" })
    vim.keymap.set("n", "<leader>nd", require("package-info").delete, { desc = "Delete package" })
    vim.keymap.set("n", "<leader>ni", require("package-info").install, { desc = "Install package" })
    vim.keymap.set("n", "<leader>nc", require("package-info").change_version, { desc = "Change version" })
  end,
}