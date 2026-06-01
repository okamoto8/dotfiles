return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-python",
      "sidlatau/neotest-dart",
    },
    keys = {
      {
        "<leader>tt",
        function()
          require("neotest").run.run()
        end,
        desc = "Test: Run Nearest",
      },
      {
        "<leader>tf",
        function()
          require("neotest").run.run(vim.fn.expand("%"))
        end,
        desc = "Test: Run File",
      },
      {
        "<leader>ts",
        function()
          require("neotest").summary.toggle()
        end,
        desc = "Test: Toggle Summary",
      },
      {
        "<leader>to",
        function()
          require("neotest").output_panel.toggle()
        end,
        desc = "Test: Toggle Output Panel",
      },
      {
        "<leader>tO",
        function()
          require("neotest").output.open({ enter = true })
        end,
        desc = "Test: Show Output",
      },
      {
        "<leader>ta",
        function()
          require("neotest").run.run(vim.fn.getcwd())
        end,
        desc = "Test: Run All",
      },
      {
        "<leader>tS",
        function()
          require("neotest").run.stop()
        end,
        desc = "Test: Stop",
      },
    },
    config = function()
      require("neotest").setup({
        discovery = {
          filter_dir = function(name)
            -- buildディレクトリなど不要なものを除外
            return not vim.tbl_contains({ "build", ".git", "node_modules", "__pycache__" }, name)
          end,
        },
        adapters = {
          require("neotest-python")({
            dap = { justMyCode = false },
            runner = "pytest",
            -- 現在のファイルから上に向かって .venv を探す
            python = function()
              local path = vim.fn.expand("%:p:h")
              for _ = 1, 10 do
                local venv = path .. "/.venv/bin/python"
                if vim.fn.executable(venv) == 1 then
                  return venv
                end
                local parent = vim.fn.fnamemodify(path, ":h")
                if parent == path then break end
                path = parent
              end
              return "python"
            end,
            -- django/pytest.ini を root として認識させる
            root = function(file)
              return require("neotest.lib").files.match_root_pattern(
                "pytest.ini", "pyproject.toml", "setup.cfg", "setup.py"
              )(file)
            end,
          }),
          require("neotest-dart")({
            command = "flutter",
            use_lsp = false,
          }),
        },
      })
    end,
  },
}
