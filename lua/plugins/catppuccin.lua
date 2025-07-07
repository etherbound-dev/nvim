return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    -- Function to determine theme based on time
    local function get_theme_by_time()
      local hour = tonumber(os.date("%H"))
      -- Use latte (light) theme from 6 AM to 6 PM, mocha (dark) otherwise
      if hour >= 6 and hour < 18 then
        return "latte"
      else
        return "mocha"
      end
    end

    require("catppuccin").setup({
      flavour = get_theme_by_time(),
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

    -- Auto-update theme every hour
    vim.api.nvim_create_augroup("CatppuccinTimeTheme", { clear = true })
    vim.api.nvim_create_autocmd({ "VimEnter", "FocusGained" }, {
      group = "CatppuccinTimeTheme",
      callback = function()
        local current_theme = get_theme_by_time()
        if require("catppuccin").flavour ~= current_theme then
          vim.cmd("Catppuccin " .. current_theme)
        end
      end,
    })
  end,
}
