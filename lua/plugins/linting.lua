return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
    }

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        -- Get the current file's directory
        local current_file = vim.api.nvim_buf_get_name(0)
        local current_dir = vim.fs.dirname(current_file)
        
        -- Find the nearest directory containing eslint config
        local config_files = {
          ".eslintrc",
          ".eslintrc.js",
          ".eslintrc.cjs",
          ".eslintrc.yaml",
          ".eslintrc.yml",
          ".eslintrc.json",
          "eslint.config.js",
          "eslint.config.mjs",
          "eslint.config.cjs",
        }
        
        local found = vim.fs.find(config_files, {
          upward = true,
          path = current_dir,
          stop = vim.loop.os_homedir(),
        })
        
        if found[1] then
          -- Change to the directory containing the eslint config before linting
          local eslint_root = vim.fs.dirname(found[1])
          local original_cwd = vim.fn.getcwd()
          vim.fn.chdir(eslint_root)
          lint.try_lint()
          vim.fn.chdir(original_cwd)
        else
          -- Just run lint in current directory
          lint.try_lint()
        end
      end,
    })
  end,
}