-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
  -- first key is the mode
  n = {
    -- second key is the lefthand side of the map

    -- navigate buffer tabs with `H` and `L`
    ["<Tab>"] = {
      function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
      desc = "Next buffer",
    },
    -- H = {
    --   function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
    --   desc = "Previous buffer",
    -- },

    -- mappings seen under group name "Buffer"
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(
          function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
        )
      end,
      desc = "Pick to close",
    },
    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    ["<leader>b"] = { name = "Buffers" },
    -- git
    ["<leader>gn"] = {
      "<cmd> Neogit kind=vsplit <CR>",
      desc = "Start a floating window with Neogit",
    },
    ["M"] = {
      "<cmd> m +1 <CR>",
      desc = "down",
    },
    ["m"] = {
      "<cmd> m -2 <CR>",
      desc = "up",
    },
    ["b"] = {
      "<cmd> vertical resize +1 <CR>",
      desc = "Increase width",
    },
    ["B"] = {
      "<cmd> vertical resize -1 <CR>",
      desc = "Decrease width",
    },
    ["S"] = {
      "<cmd> DocsViewToggle <CR>",
      desc = "Docs",
    },
    -- rust
    ["A"] = {
      "<cmd> RustLsp hover actions <CR>",
      desc = "Rust hover actions",
    },
    ["<leader>rs"] = {
      "<cmd> RustLsp syntaxTree <CR>",
      desc = "View Syntax Tree",
    },
    ["<leader>re"] = {
      "<cmd> RustLsp explainError <CR>",
      desc = "Explain errors",
    },
    ["<leader>rh"] = {
      function() require "ferris.methods.view_hir"() end,
      desc = "View HIR",
    },
    ["<leader>rm"] = {
      function() require "ferris.methods.view_mir"() end,
      desc = "View MIR",
    },
    ["<leader>rM"] = {
      function() require "ferris.methods.view_memory_layout"() end,
      desc = "View Memory Layout",
    },
    ["<leader>ri"] = {
      function() require "ferris.methods.view_item_tree"() end,
      desc = "View Item Tree",
    },
    ["<leader>rt"] = {
      function() require("lsp-inlayhints").toggle() end,
      desc = "View Inlay Hints",
    },
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
}
