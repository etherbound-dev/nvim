return {
  "romgrk/barbar.nvim",
  dependencies = {
    "lewis6991/gitsigns.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  init = function()
    vim.g.barbar_auto_setup = false
  end,
  opts = {
    -- animation
    animation = true,

    -- auto-hide
    auto_hide = false,

    -- tabpages
    tabpages = true,

    -- clickable
    clickable = true,

    -- exclude filetypes
    exclude_ft = { "neo-tree" },

    -- icons
    icons = {
      buffer_index = false,
      buffer_number = false,
      button = "",
      diagnostics = {
        [vim.diagnostic.severity.ERROR] = { enabled = true, icon = "ﬀ" },
        [vim.diagnostic.severity.WARN] = { enabled = false },
        [vim.diagnostic.severity.INFO] = { enabled = false },
        [vim.diagnostic.severity.HINT] = { enabled = true },
      },
      gitsigns = {
        added = { enabled = true, icon = "+" },
        changed = { enabled = true, icon = "~" },
        deleted = { enabled = true, icon = "-" },
      },
      filetype = {
        custom_colors = false,
        enabled = true,
      },
      separator = { left = "▎", right = "" },
      modified = { button = "●" },
      pinned = { button = "", filename = true },
      preset = "default",
      alternate = { filetype = { enabled = false } },
      current = { buffer_index = true },
      inactive = { button = "×" },
      visible = { modified = { buffer_number = false } },
    },

    -- insert at end
    insert_at_end = false,
    insert_at_start = false,

    -- maximum padding
    maximum_padding = 1,
    minimum_padding = 1,
    maximum_length = 30,
    minimum_length = 0,

    -- semantic letters
    semantic_letters = true,

    -- sidebar filetypes
    sidebar_filetypes = {
      ["neo-tree"] = { event = "BufWipeout" },
    },

    -- letters
    letters = "asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP",

    -- no name title
    no_name_title = nil,
  },
  config = function(_, opts)
    require("barbar").setup(opts)

    -- Keymaps
    local map = vim.api.nvim_set_keymap
    local opts = { noremap = true, silent = true }

    -- Move to previous/next
    map("n", "<A-,>", "<Cmd>BufferPrevious<CR>", opts)
    map("n", "<A-.>", "<Cmd>BufferNext<CR>", opts)
    -- Re-order to previous/next
    map("n", "<A-<>", "<Cmd>BufferMovePrevious<CR>", opts)
    map("n", "<A->>", "<Cmd>BufferMoveNext<CR>", opts)
    -- Goto buffer in position...
    map("n", "<A-1>", "<Cmd>BufferGoto 1<CR>", opts)
    map("n", "<A-2>", "<Cmd>BufferGoto 2<CR>", opts)
    map("n", "<A-3>", "<Cmd>BufferGoto 3<CR>", opts)
    map("n", "<A-4>", "<Cmd>BufferGoto 4<CR>", opts)
    map("n", "<A-5>", "<Cmd>BufferGoto 5<CR>", opts)
    map("n", "<A-6>", "<Cmd>BufferGoto 6<CR>", opts)
    map("n", "<A-7>", "<Cmd>BufferGoto 7<CR>", opts)
    map("n", "<A-8>", "<Cmd>BufferGoto 8<CR>", opts)
    map("n", "<A-9>", "<Cmd>BufferGoto 9<CR>", opts)
    map("n", "<A-0>", "<Cmd>BufferLast<CR>", opts)
    -- Pin/unpin buffer
    map("n", "<A-p>", "<Cmd>BufferPin<CR>", opts)
    -- Close buffer
    map("n", "<A-c>", "<Cmd>BufferClose<CR>", opts)
    -- Wipeout buffer
    --                 :BufferWipeout
    -- Close commands
    --                 :BufferCloseAllButCurrent
    --                 :BufferCloseAllButPinned
    --                 :BufferCloseAllButCurrentOrPinned
    --                 :BufferCloseBuffersLeft
    --                 :BufferCloseBuffersRight
    -- Magic buffer-picking mode
    map("n", "<C-p>", "<Cmd>BufferPick<CR>", opts)
    -- Sort automatically by...
    map("n", "<Space>bb", "<Cmd>BufferOrderByBufferNumber<CR>", opts)
    map("n", "<Space>bd", "<Cmd>BufferOrderByDirectory<CR>", opts)
    map("n", "<Space>bl", "<Cmd>BufferOrderByLanguage<CR>", opts)
    map("n", "<Space>bw", "<Cmd>BufferOrderByWindowNumber<CR>", opts)

    -- Other:
    -- :BarbarEnable - enables barbar (enabled by default)
    -- :BarbarDisable - very bad command, should never be used
  end,
  version = "^1.0.0",
}