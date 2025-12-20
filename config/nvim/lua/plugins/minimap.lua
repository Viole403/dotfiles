return {
  "echasnovski/mini.map",
  lazy = false,
  config = function()
    local map = require("mini.map")

    map.setup({
      integrations = {
        map.gen_integration.builtin_search(),
        map.gen_integration.diagnostic({ error = "ErrorMsg", warn = "WarningMsg", info = "None", hint = "None" }),
      },
      symbols = {
        encode = map.gen_encode_symbols.dot("4x2"),
      },
      window = {
        side = "right",
        width = 10,
        winblend = 0,
        show_integration_count = false,
        focusable = false,
      },
    })

    -- Toggle mapping
    vim.keymap.set("n", "<leader>mm", map.toggle, { desc = "Toggle MiniMap" })

    -- Close any existing minimap windows before opening
    vim.defer_fn(function()
      -- Close all minimap windows first
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        if vim.api.nvim_buf_is_valid(buf) then
          local ft = vim.api.nvim_buf_get_option(buf, "filetype")
          if ft == "minimap" then
            pcall(vim.api.nvim_win_close, win, true)
          end
        end
      end

      -- Now open a fresh minimap
      pcall(map.open)
    end, 200)
  end,
}