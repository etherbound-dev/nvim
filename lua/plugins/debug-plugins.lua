return {
  {
    "folke/lazy.nvim",
    keys = {
      {
        "<leader>pl",
        function()
          -- Check if plugins are loaded
          local loaded_plugins = {}
          for name, plugin in pairs(require("lazy.core.config").plugins) do
            if plugin._.loaded then
              loaded_plugins[name] = true
            end
          end
          
          -- Check specific plugins
          local plugins_to_check = { "which-key.nvim", "nvim-cmp" }
          local status = {}
          
          for _, plugin_name in ipairs(plugins_to_check) do
            local is_loaded = loaded_plugins[plugin_name] or false
            local ok, module = pcall(require, plugin_name:gsub("%.nvim$", ""):gsub("^nvim%-", ""))
            
            status[plugin_name] = {
              loaded = is_loaded,
              module_available = ok,
              module = ok and module or nil
            }
          end
          
          -- Display status
          print("Plugin Status:")
          print("==============")
          for name, info in pairs(status) do
            print(string.format("%s: loaded=%s, module=%s", 
              name, 
              tostring(info.loaded), 
              tostring(info.module_available)
            ))
          end
          
          -- Check keybindings
          print("\nWhich-key keybinding check:")
          local which_key_binding = vim.fn.maparg("<leader>?", "n")
          print("  <leader>? mapping: " .. (which_key_binding ~= "" and "exists" or "missing"))
          
          -- Check if nvim-cmp is active
          print("\nnvim-cmp status:")
          local ok_cmp, cmp = pcall(require, "cmp")
          if ok_cmp then
            print("  cmp module loaded: true")
            print("  cmp enabled: " .. tostring(cmp.get_config().enabled))
          else
            print("  cmp module loaded: false")
          end
        end,
        desc = "Check plugin status"
      },
      {
        "<leader>pr",
        function()
          -- Reload specific plugins
          local plugins = { "which-key", "cmp" }
          for _, plugin in ipairs(plugins) do
            pcall(function()
              package.loaded[plugin] = nil
              require(plugin)
            end)
          end
          print("Attempted to reload which-key and nvim-cmp")
        end,
        desc = "Reload which-key and nvim-cmp"
      }
    }
  }
}