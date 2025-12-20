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
      },
      on_click = "scroll",
    })

    -- Optional: toggle mapping
    vim.keymap.set("n", "<leader>mm", map.toggle, { desc = "Toggle MiniMap" })

    -- Optional: auto-show for all buffers
    map.open()
  end,
}