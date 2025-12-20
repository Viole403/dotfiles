-- plugins/project.lua
return {
  "ahmedkhalf/project.nvim",
  lazy = false,
  config = function()
    local ok, project = pcall(require, "project_nvim")
    if ok then
      project.setup({})
      pcall(require("telescope").load_extension, "projects")
    end
  end
}
