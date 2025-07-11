return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    -- Store current theme in global variable
    vim.g.catppuccin_flavour = vim.g.catppuccin_flavour or "latte"

    require("catppuccin").setup({
      flavour = vim.g.catppuccin_flavour,
      background = {
        light = "latte",
        dark = "mocha",
      },
      transparent_background = false,
      show_end_of_buffer = false,
      term_colors = true,
      dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.15,
      },
      styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
      },
      integrations = {
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
          },
          underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
          },
        },
      },
    })
    -- Set colorscheme
    vim.cmd.colorscheme "catppuccin"

    -- Function to toggle between latte and mocha
    vim.api.nvim_create_user_command("CatppuccinToggle", function()
      if vim.g.catppuccin_flavour == "mocha" then
        vim.g.catppuccin_flavour = "latte"
      else
        vim.g.catppuccin_flavour = "mocha"
      end
      vim.cmd("Catppuccin " .. vim.g.catppuccin_flavour)
    end, {})
  end,
}
