return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("fzf-lua").setup({
      fzf_colors = {
        ["fg"] = { "fg", "CursorLine" },
        ["bg"] = { "bg", "Normal" },
        ["hl"] = { "fg", "Comment" },
        ["fg+"] = { "fg", "Normal" },
        ["bg+"] = { "bg", "CursorLine" },
        ["hl+"] = { "fg", "Statement" },
        ["info"] = { "fg", "PreProc" },
        ["prompt"] = { "fg", "Conditional" },
        ["pointer"] = { "fg", "Exception" },
        ["marker"] = { "fg", "Keyword" },
        ["spinner"] = { "fg", "Label" },
        ["header"] = { "fg", "Comment" }
      },
      winopts = {
        height = 0.85,
        width = 0.80,
        preview = {
          default = "builtin",
          builtin = {
            syntax = true,
            treesitter = { enable = true }
          }
        }
      },
      files = {
        prompt = "Files> ",
        multiprocess = true,
        git_icons = true,
        file_icons = true,
        color_icons = true,
        fd_opts = "--color=never --type f --hidden --follow --exclude .git",
      },
      grep = {
        prompt = "Rg> ",
        multiprocess = true,
        git_icons = true,
        file_icons = true,
        color_icons = true,
        rg_opts = "--column --line-number --no-heading --color=always --smart-case --hidden --glob '!.git'",
      },
    })
  end,
}