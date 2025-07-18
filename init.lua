-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Basic Neovim settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"
vim.opt.undofile = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 50
vim.opt.ruler = false
vim.opt.showcmd = false

-- Set leader key BEFORE loading plugins
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Setup lazy.nvim with plugins from lua/plugins directory
require("lazy").setup("plugins")

-- File navigation keymaps with fzf-lua
vim.keymap.set('n', '<leader>ff', '<cmd>FzfLua files<cr>', { desc = "Find files" })
vim.keymap.set('n', '<leader>fg', '<cmd>FzfLua live_grep<cr>', { desc = "Live grep" })
vim.keymap.set('n', '<leader>fb', '<cmd>FzfLua buffers<cr>', { desc = "Find buffers" })
vim.keymap.set('n', '<leader>fo', '<cmd>FzfLua oldfiles<cr>', { desc = "Recent files" })
vim.keymap.set('n', '<leader>fh', '<cmd>FzfLua help_tags<cr>', { desc = "Help tags" })
vim.keymap.set('n', '<leader>fs', '<cmd>FzfLua grep_cword<cr>', { desc = "Search word under cursor" })
vim.keymap.set('n', '<leader>fd', '<cmd>FzfLua diagnostics_document<cr>', { desc = "Document diagnostics" })
vim.keymap.set('n', '<leader>fr', '<cmd>FzfLua lsp_references<cr>', { desc = "LSP references" })

-- Buffer management keymaps
vim.keymap.set('n', '<leader>bd', '<cmd>BufferClose<cr>', { desc = "Delete buffer" })
vim.keymap.set('n', '<leader>bD', '<cmd>BufferClose!<cr>', { desc = "Force delete buffer" })
vim.keymap.set('n', '<leader>bn', '<cmd>bnext<cr>', { desc = "Next buffer" })
vim.keymap.set('n', '<leader>bp', '<cmd>bprevious<cr>', { desc = "Previous buffer" })
vim.keymap.set('n', '<leader>bb', '<cmd>FzfLua buffers<cr>', { desc = "Switch buffer" })
vim.keymap.set('n', '<leader>ba', '<cmd>ball<cr>', { desc = "Open all buffers" })
vim.keymap.set('n', '<leader>bc', '<cmd>bdelete<cr><cmd>bprevious<cr>', { desc = "Close buffer and go to previous" })
vim.keymap.set('n', '<leader>bo', '<cmd>%bdelete|edit#|bdelete<cr>', { desc = "Close other buffers" })

-- Quick buffer switching with numbers
for i = 1, 9 do
  vim.keymap.set('n', '<leader>b' .. i, '<cmd>buffer ' .. i .. '<cr>', { desc = "Go to buffer " .. i })
end

-- Clear search highlighting with Escape
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<cr>', { desc = "Clear search highlighting" })

-- Toggle between catppuccin-latte and catppuccin-mocha
vim.keymap.set('n', '<leader>tt', '<cmd>CatppuccinToggle<cr>', { desc = "Toggle theme (latte/mocha)" })

-- File explorer keymap is now in lua/plugins/explorer.lua

-- Window management keymaps
vim.keymap.set('n', '<leader>wv', '<cmd>vsplit<cr>', { desc = "Split window vertically" })
vim.keymap.set('n', '<leader>ws', '<cmd>split<cr>', { desc = "Split window horizontally" })
vim.keymap.set('n', '<leader>wc', '<cmd>close<cr>', { desc = "Close current window" })
vim.keymap.set('n', '<leader>wo', '<cmd>only<cr>', { desc = "Close other windows" })
vim.keymap.set('n', '<leader>ww', '<C-w>w', { desc = "Switch windows" })
vim.keymap.set('n', '<leader>wj', '<C-w>j', { desc = "Go to window below" })
vim.keymap.set('n', '<leader>wk', '<C-w>k', { desc = "Go to window above" })
vim.keymap.set('n', '<leader>wl', '<C-w>l', { desc = "Go to window right" })
vim.keymap.set('n', '<leader>wh', '<C-w>h', { desc = "Go to window left" })
vim.keymap.set('n', '<leader>w=', '<C-w>=', { desc = "Equal window sizes" })
vim.keymap.set('n', '<leader>w>', '<C-w>5>', { desc = "Increase window width" })
vim.keymap.set('n', '<leader>w<', '<C-w>5<', { desc = "Decrease window width" })
vim.keymap.set('n', '<leader>w+', '<C-w>5+', { desc = "Increase window height" })
vim.keymap.set('n', '<leader>w-', '<C-w>5-', { desc = "Decrease window height" })

-- LSP Configuration using built-in vim.lsp
local function setup_lsp()
  -- Create an autocmd group for LSP
  local lsp_group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true })

  -- Set up LSP keymaps when LSP attaches
  vim.api.nvim_create_autocmd('LspAttach', {
    group = lsp_group,
    callback = function(args)
      local bufnr = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      
      -- Enable completion triggered by <c-x><c-o>
      vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

      -- Buffer local mappings
      local opts = { buffer = bufnr, noremap = true, silent = true }
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
      vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
      vim.keymap.set('n', '<space>lwa', vim.lsp.buf.add_workspace_folder, opts)
      vim.keymap.set('n', '<space>lwr', vim.lsp.buf.remove_workspace_folder, opts)
      vim.keymap.set('n', '<space>lwl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, opts)
      vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
      vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
      vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
      -- Remove the LSP format keymap since conform.nvim will handle it
      -- vim.keymap.set('n', '<space>cf', function() vim.lsp.buf.format { async = false } end, opts)
    end,
  })

  -- Start TypeScript language server for .ts, .tsx, .js, .jsx files
  vim.api.nvim_create_autocmd('FileType', {
    group = lsp_group,
    pattern = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
    callback = function(event)
      local bufnr = event.buf
      
      -- Custom root directory finder that respects submodule boundaries
      local function find_root()
        local current_file = vim.api.nvim_buf_get_name(bufnr)
        local current_dir = vim.fs.dirname(current_file)
        
        -- First, try to find package.json or tsconfig.json
        local markers = vim.fs.find({ 'package.json', 'tsconfig.json' }, {
          upward = true,
          path = current_dir,
        })
        
        if markers[1] then
          return vim.fs.dirname(markers[1])
        end
        
        -- If no package.json/tsconfig.json found, use the nearest .git
        -- This ensures submodules use their own .git as root
        local git_dir = vim.fs.find({ '.git' }, {
          upward = true,
          path = current_dir,
        })
        
        if git_dir[1] then
          return vim.fs.dirname(git_dir[1])
        end
        
        -- Fallback to current directory
        return current_dir
      end
      
      local root_dir = find_root()
      
      -- Check if we already have a client for this specific root
      local clients = vim.lsp.get_clients({ bufnr = bufnr })
      for _, client in pairs(clients) do
        if client.name == 'ts_ls' and client.config.root_dir == root_dir then
          -- Already have the right client attached
          return
        elseif client.name == 'ts_ls' and client.config.root_dir ~= root_dir then
          -- Wrong client attached, detach it from this buffer
          vim.lsp.buf_detach_client(bufnr, client.id)
        end
      end
      
      -- Look for existing client with matching root
      local all_clients = vim.lsp.get_clients({ name = 'ts_ls' })
      for _, client in pairs(all_clients) do
        if client.config.root_dir == root_dir then
          -- Attach existing client to this buffer
          vim.lsp.buf_attach_client(bufnr, client.id)
          return
        end
      end
      
      -- No suitable client found, start a new one
      vim.lsp.start({
        name = 'ts_ls',
        cmd = { 'typescript-language-server', '--stdio' },
        root_dir = root_dir,
        single_file_support = false,
        capabilities = (function()
          local capabilities = vim.lsp.protocol.make_client_capabilities()
          -- Try to use cmp_nvim_lsp if available
          local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
          if ok then
            capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
          end
          return capabilities
        end)(),
      }, {
        bufnr = bufnr,
      })
    end,
  })
end

-- Initialize LSP
setup_lsp()

-- Diagnostic settings
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

-- Diagnostic keymaps
vim.keymap.set('n', '<space>cd', vim.diagnostic.open_float, { desc = "Open diagnostic float" })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Debug keymap to show LSP root directory
vim.keymap.set('n', '<leader>lr', function()
  local bufnr = vim.api.nvim_get_current_buf()
  local buf_clients = vim.lsp.get_clients({ bufnr = bufnr })
  
  print("=== Current Buffer LSP Clients ===")
  if next(buf_clients) == nil then
    print("No LSP clients attached to current buffer")
  else
    for _, client in pairs(buf_clients) do
      print(string.format("  %s: %s", client.name, client.config.root_dir))
    end
  end
  
  print("\n=== All Active LSP Clients ===")
  local all_clients = vim.lsp.get_clients()
  for _, client in pairs(all_clients) do
    local attached_buffers = vim.lsp.get_buffers_by_client_id(client.id)
    print(string.format("  %s: %s (attached to %d buffers)", 
      client.name, client.config.root_dir, #attached_buffers))
  end
end, { desc = "Show LSP root directories" })

-- Debug keymap for ESLint
vim.keymap.set('n', '<leader>le', function()
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_dir = vim.fs.dirname(current_file)
  
  print("Current file: " .. current_file)
  print("Current dir: " .. current_dir)
  
  -- Check for eslint config
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
    print("ESLint config found: " .. found[1])
    print("ESLint working directory: " .. vim.fs.dirname(found[1]))
  else
    print("No ESLint config found!")
  end
  
  -- Test eslint_d directly
  local cmd = string.format("cd %s && eslint_d --print-config %s", vim.fs.dirname(found[1] or current_file), current_file)
  local result = vim.fn.system(cmd)
  if vim.v.shell_error ~= 0 then
    print("ESLint error: " .. result)
  else
    print("ESLint is working correctly")
  end
end, { desc = "Debug ESLint configuration" })

-- Show diagnostics in a floating window on hover (disabled)
vim.o.updatetime = 250
-- vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

-- Automatically create directories when saving a file
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    local dir = vim.fn.fnamemodify(args.file, ":p:h")
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, "p")
    end
  end,
  desc = "Auto-create missing directories when saving"
})

-- Completion settings
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}
