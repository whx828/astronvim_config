return {
  -- Show neo-tree hidden files by default
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          visible = true,
        },
      },
    },
  },
  {
    "stevearc/oil.nvim",
    opts = {},
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "-", "<cmd> Oil <CR>", desc = "Open parent directory" },
    },
    config = function() require("oil").setup() end,
  },

  -- Play
  {
    "eandrju/cellular-automaton.nvim",
    keys = {
      { "<leader>fl", "<cmd>CellularAutomaton make_it_rain<CR>", desc = "rain" },
    },
  },
  {
    "jim-fx/sudoku.nvim",
    cmd = "Sudoku",
    config = function() require("sudoku").setup {} end,
  },

  -- Color the border of active window
  {
    "nvim-zh/colorful-winsep.nvim",
    event = { "WinNew" },
    config = function()
      local colorful_winsep = require "colorful-winsep"
      require("colorful-winsep").setup {
        create_event = function()
          -- Executed after creating the window separator
          local win_n = require("colorful-winsep.utils").calculate_number_windows()
          if win_n == 2 then
            local win_id = vim.fn.win_getid(vim.fn.winnr "h")
            local filetype = vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(win_id), "filetype")
            if filetype == "NvimTree" then colorful_winsep.NvimSeparatorDel() end
          end
        end,
      }
    end,
  },

  -- regex
  {
    "bennypowers/nvim-regexplainer",
    ft = {
      "rust",
      "go",
      "html",
      "js",
    },
    config = function()
      -- defaults
      require("regexplainer").setup {
        -- 'narrative'
        mode = "narrative", -- TODO: 'ascii', 'graphical'

        -- automatically show the explainer when the cursor enters a regexp
        auto = false,

        -- filetypes (i.e. extensions) in which to run the autocommand
        filetypes = {
          "rust",
          "go",
          "html",
          "js",
        },

        -- Whether to log debug messages
        debug = false,

        -- 'split', 'popup'
        display = "popup",

        mappings = {
          toggle = "gR",
          -- examples, not defaults:
          -- show = 'gS',
          -- hide = 'gH',
          -- show_split = 'gP',
          -- show_popup = 'gU',
        },

        narrative = {
          separator = "\n",
        },
      }
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "MunifTanjim/nui.nvim",
    },
  },

  {
    "potamides/pantran.nvim",
    ft = { "c", "cpp", "lua", "rust", "go", "markdown" },
    config = function()
      require("pantran").setup {
        -- Default engine to use for translation. To list valid engine names run
        -- `:lua =vim.tbl_keys(require("pantran.engines"))`.
        default_engine = "google",
      }
    end,
  },

  -- git
  {
    "NeogitOrg/neogit",
    ft = { "c", "cpp", "lua", "rust", "go" },
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "nvim-telescope/telescope.nvim", -- optional
      "sindrets/diffview.nvim", -- optional
      "ibhagwan/fzf-lua", -- optional
    },
    config = function() require("neogit").setup {} end,
  },

  -- window
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
    config = function()
      require("noice").setup {
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
          signature = { enabled = false },
          hover = { enabled = false },
          message = { enabled = false },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },
      }
    end,
  },

  -- search
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function() require("flash").jump() end,
        desc = "Flash",
      },
      {
        "<leader>s",
        mode = { "n", "x", "o" },
        function() require("flash").treesitter() end,
        desc = "Flash Treesitter",
      },
    },
  },

  -- rust
  {
    "nvimdev/lspsaga.nvim",
    ft = { "c", "cpp", "lua", "rust", "go" },
    config = function() require("lspsaga").setup {} end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter", -- optional
    },
  },
  {
    "amrbashir/nvim-docs-view",
    ft = { "rust", "go" },
    config = function()
      require("docs-view").setup {
        position = "bottom",
        height = 20,
      }
    end,
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^3", -- Recommended
    event = "VeryLazy",
    ft = { "rust" },
  },
  {
    "vxpm/ferris.nvim",
    ft = { "rust" },
    opts = {
      -- your options here
      -- If true, will automatically create commands for each LSP method
      create_commands = true, -- bool
      -- Handler for URL's (used for opening documentation)
      url_handler = "xdg-open", -- string | function(string)
    },
  },
  {
    "lvimuser/lsp-inlayhints.nvim",
    opts = {},
    lazy = true,
    init = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("LspAttach_inlayhints", {}),
        callback = function(args)
          if not (args.data and args.data.client_id) then return end
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          require("lsp-inlayhints").on_attach(client, args.buf)
        end,
      })
    end,
  },
  -- color
  {
    "xero/miasma.nvim",
    lazy = false,
    priority = 1000,
    config = function() vim.cmd "colorscheme miasma" end,
  },
  {
    "AlexvZyl/nordic.nvim",
    lazy = false,
    priority = 1000,
    config = function() require("nordic").load() end,
  },
}
