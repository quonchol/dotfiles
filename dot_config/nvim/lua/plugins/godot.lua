return {
  {
    "nvim-lspconfig",
    opts = {
      servers = {
        gdscript = {
          cmd = { "nc", "localhost", "6005" }, -- Default Godot LSP port
          filetypes = { "gd", "gdscript", "gdscript3" },
          root_dir = function()
            return vim.fn.getcwd()
          end,
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "gdscript",
      },
    },
  },
}
