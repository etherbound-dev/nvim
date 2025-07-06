# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a modern Neovim configuration written entirely in Lua, using lazy.nvim as the plugin manager. The configuration is optimized for JavaScript/TypeScript development with native LSP support.

## Architecture

### Directory Structure
- `init.lua` - Main entry point containing core settings, lazy.nvim bootstrap, and keymaps
- `lua/plugins/` - Individual plugin configurations, each file returns a lazy.nvim plugin spec
- `lazy-lock.json` - Plugin version lock file managed by lazy.nvim

### Plugin System
The configuration uses lazy.nvim's modular approach where `require("lazy").setup("plugins")` automatically loads all files from `lua/plugins/`. Each plugin file should return a table with the plugin specification.

### Key Design Patterns
1. **Lazy Loading**: Plugins load on-demand via events, commands, or keybindings
2. **Modular Configuration**: Each plugin has its own file in `lua/plugins/`
3. **Consistent Keybindings**: Leader key is space, mappings grouped by functionality (f=find, b=buffer, w=window, c=code)

## Common Development Tasks

### Adding a New Plugin
Create a new file in `lua/plugins/` that returns a plugin specification:
```lua
return {
  "author/plugin-name",
  event = "VeryLazy", -- or other loading trigger
  config = function()
    -- plugin configuration
  end,
}
```

### Modifying Keybindings
- Global keybindings are in `init.lua` after the plugin setup
- Plugin-specific keybindings should be in the plugin's config function
- Follow the existing pattern: `<leader>` + category letter + action

### Updating Plugins
```bash
# Update all plugins
nvim --headless "+Lazy! sync" +qa

# Update specific plugin
nvim --headless "+Lazy! update plugin-name" +qa
```

### Debugging Configuration
```bash
# Check for errors
nvim --headless "+checkhealth" +qa

# Test minimal config
nvim -u NONE -c "lua require('init')"
```

## Language Server Configuration

The TypeScript/JavaScript LSP is configured directly in `init.lua` using native Neovim LSP. To add new language servers:
1. Install the server binary (usually via npm, cargo, go, etc.)
2. Add configuration in the LSP section of `init.lua`
3. Update formatting/linting configurations in respective plugin files if needed

## Plugin-Specific Notes

### Formatting (conform.nvim)
- Configured for auto-format on save with 500ms timeout
- Uses `prettierd` for better performance
- Add new formatters in `lua/plugins/formatting.lua`

### Linting (nvim-lint)
- Uses `eslint_d` for JavaScript/TypeScript
- Triggers on BufWritePost, BufReadPost, and InsertLeave
- Add new linters in `lua/plugins/linting.lua`

### Completion (nvim-cmp)
- Sources: LSP, buffer, path, luasnip
- Tab/Shift-Tab for navigation
- Configure in `lua/plugins/completion.lua`

## Important Conventions

1. **No VimScript**: This config is 100% Lua. Use Lua APIs instead of vim commands where possible
2. **Performance First**: Prefer lazy loading and faster alternatives (eslint_d over eslint, prettierd over prettier)
3. **Minimal External Dependencies**: The config is self-contained except for language servers and formatters/linters