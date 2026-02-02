return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  keys = {
    { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
    { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
    { "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete Other Buffers" },
    { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
    { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
    { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
    { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
    { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
    { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
    { "[B", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" },
    { "]B", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" },
  },
  opts = {
    options = {
      -- Use standard buffer delete
      close_command = "bdelete! %d",
      right_mouse_command = "bdelete! %d",

      -- Show LSP diagnostics in bufferline
      diagnostics = "nvim_lsp",
      always_show_bufferline = false,

      -- Show diagnostic counts (E:2 W:1)
      diagnostics_indicator = function(_, _, diag)
        local ret = (diag.error and "E:" .. diag.error .. " " or "")
          .. (diag.warning and "W:" .. diag.warning or "")
        return vim.trim(ret)
      end,

      offsets = {
        {
          filetype = "neo-tree",
          text = "Neo-tree",
          highlight = "Directory",
          text_align = "left",
        },
      },

      -- Basic filetype icons (no LazyVim)
      get_element_icon = function(opts)
        local icons = {
          lua = "",
          python = "",
          cpp = "",
          c = "",
          txt = "",
          markdown = "",
        }
        return icons[opts.filetype] or ""
      end,
    },
  },
  config = function(_, opts)
    require("bufferline").setup(opts)
  end,
}
