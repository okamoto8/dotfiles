return {
  -- LSP settings
  {
    "neovim/nvim-lspconfig",
    init = function()
      local function disable_inlay_hints(bufnr)
        if not (vim.lsp and vim.lsp.inlay_hint and vim.lsp.inlay_hint.enable) then
          return
        end

        -- Neovim 0.11 style: enable(boolean, { bufnr = ... })
        pcall(vim.lsp.inlay_hint.enable, false, { bufnr = bufnr })
        -- Neovim 0.10 style: enable(bufnr, boolean)
        pcall(vim.lsp.inlay_hint.enable, bufnr, false)
      end

      local group = vim.api.nvim_create_augroup("user_lsp_keymaps", { clear = true })
      vim.api.nvim_create_autocmd("LspAttach", {
        group = group,
        callback = function(args)
          local bufnr = args.buf
          disable_inlay_hints(bufnr)

        local map = function(lhs, rhs, desc)
          vim.keymap.set("n", lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
        end

        map("gd", vim.lsp.buf.definition, "Goto Definition")
        map("gD", vim.lsp.buf.declaration, "Goto Declaration")
        map("gr", vim.lsp.buf.references, "References")
        map("gi", vim.lsp.buf.implementation, "Goto Implementation")
        map("gt", vim.lsp.buf.type_definition, "Type Definition")
        map("K", vim.lsp.buf.hover, "Hover")
        map("<leader>rn", vim.lsp.buf.rename, "Rename")
        map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
        map("<leader>f", function()
          vim.lsp.buf.format({ async = true })
        end, "Format")
        end,
      })
    end,
    opts = {
      inlay_hints = {
        enabled = false,
      },
      servers = {
        pyright = { enabled = false },
        basedpyright = {
          settings = {
            basedpyright = {
              analysis = {
                autoSearchPaths = true,
                diagnosticMode = "openFilesOnly",
                useLibraryCodeForTypes = true,
                typeCheckingMode = "basic",
              },
            },
            python = {
              -- django/.venv を認識させる
              venvPath = "django/teianneoproject",
              venv = ".venv",
            },
          },
        },
        ts_ls = {},
        tailwindcss = {},
        eslint = {},
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
            },
          },
        },
        dartls = {},
      },
    },
  },

  -- Ensure LSP servers are installed via mason-lspconfig.
  {
    "mason-org/mason-lspconfig.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "basedpyright",
        "lua_ls",
        "ts_ls",
        "tailwindcss",
        "eslint",
      })
    end,
  },

  -- Completion settings
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    opts = function(_, opts)
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      opts.mapping = cmp.mapping.preset.insert(vim.tbl_extend("force", opts.mapping or {}, {
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }))

      opts.sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
      })
    end,
  },
}