return { -- tailwind
{
    "neovim/nvim-lspconfig",
    opts = {
        servers = {
            tailwindcss = {}
        }
    }
}, {
    "NvChad/nvim-colorizer.lua",
    opts = {
        user_default_options = {
            tailwind = true
        }
    }
}, -- mini-surround
{
    "echasnovski/mini.surround",
    recommended = true,
    keys = function(_, keys)
        -- Populate the keys based on the user's options
        local opts = LazyVim.opts("mini.surround")
        local mappings = {{
            opts.mappings.add,
            desc = "Add Surrounding",
            mode = {"n", "v"}
        }, {
            opts.mappings.delete,
            desc = "Delete Surrounding"
        }, {
            opts.mappings.find,
            desc = "Find Right Surrounding"
        }, {
            opts.mappings.find_left,
            desc = "Find Left Surrounding"
        }, {
            opts.mappings.highlight,
            desc = "Highlight Surrounding"
        }, {
            opts.mappings.replace,
            desc = "Replace Surrounding"
        }, {
            opts.mappings.update_n_lines,
            desc = "Update `MiniSurround.config.n_lines`"
        }}
        mappings = vim.tbl_filter(function(m)
            return m[1] and #m[1] > 0
        end, mappings)
        return vim.list_extend(mappings, keys)
    end,
    opts = {
        mappings = {
            add = "gsa", -- Add surrounding in Normal and Visual modes
            delete = "gsd", -- Delete surrounding
            find = "gsf", -- Find surrounding (to the right)
            find_left = "gsF", -- Find surrounding (to the left)
            highlight = "gsh", -- Highlight surrounding
            replace = "gsr", -- Replace surrounding
            update_n_lines = "gsn" -- Update `n_lines`
        }
    }
}, -- refactoring
{
    "ThePrimeagen/refactoring.nvim",
    event = {"BufReadPre", "BufNewFile"},
    dependencies = {"nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter"},
    keys = {{
        "<leader>r",
        "",
        desc = "+refactor",
        mode = {"n", "v"}
    }, {
        "<leader>rs",
        pick,
        mode = "v",
        desc = "Refactor"
    }, {
        "<leader>ri",
        function()
            require("refactoring").refactor("Inline Variable")
        end,
        mode = {"n", "v"},
        desc = "Inline Variable"
    }, {
        "<leader>rb",
        function()
            require("refactoring").refactor("Extract Block")
        end,
        desc = "Extract Block"
    }, {
        "<leader>rf",
        function()
            require("refactoring").refactor("Extract Block To File")
        end,
        desc = "Extract Block To File"
    }, {
        "<leader>rP",
        function()
            require("refactoring").debug.printf({
                below = false
            })
        end,
        desc = "Debug Print"
    }, {
        "<leader>rp",
        function()
            require("refactoring").debug.print_var({
                normal = true
            })
        end,
        desc = "Debug Print Variable"
    }, {
        "<leader>rc",
        function()
            require("refactoring").debug.cleanup({})
        end,
        desc = "Debug Cleanup"
    }, {
        "<leader>rf",
        function()
            require("refactoring").refactor("Extract Function")
        end,
        mode = "v",
        desc = "Extract Function"
    }, {
        "<leader>rF",
        function()
            require("refactoring").refactor("Extract Function To File")
        end,
        mode = "v",
        desc = "Extract Function To File"
    }, {
        "<leader>rx",
        function()
            require("refactoring").refactor("Extract Variable")
        end,
        mode = "v",
        desc = "Extract Variable"
    }, {
        "<leader>rp",
        function()
            require("refactoring").debug.print_var()
        end,
        mode = "v",
        desc = "Debug Print Variable"
    }},
    opts = {
        prompt_func_return_type = {
            go = false,
            java = false,
            cpp = false,
            c = false,
            h = false,
            hpp = false,
            cxx = false
        },
        prompt_func_param_type = {
            go = false,
            java = false,
            cpp = false,
            c = false,
            h = false,
            hpp = false,
            cxx = false
        },
        printf_statements = {},
        print_var_statements = {},
        show_success_message = true -- shows a message with information about the refactor on success
        -- i.e. [Refactor] Inlined 3 variable occurrences
    },
    config = function(_, opts)
        require("refactoring").setup(opts)
        if LazyVim.has("telescope.nvim") then
            LazyVim.on_load("telescope.nvim", function()
                require("telescope").load_extension("refactoring")
            end)
        end
    end
}, -- file-browser
{
    "nvim-telescope/telescope-file-browser.nvim",
    keys = {{
        "<leader>sB",
        ":Telescope file_browser path=%:p:h=%:p:h<cr>",
        desc = "Browse file"
    }},
    config = function()
        require("telescope").load_extension("file_browser")
    end
}, -- formater
{
    "neovim/nvim-lspconfig",
    opts = {
        servers = {
            eslint = {}
        },
        setup = {
            eslint = function()
                require("lazyvim.util").lsp.on_attach(function(client)
                    if client.name == "eslint" then
                        client.server_capabilities.documentFormattingProvider = true
                    elseif client.name == "tsserver" then
                        client.server_capabilities.documentFormattingProvider = false
                    end
                end)
            end
        }
    }
}, -- copilot
{
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
        require("copilot").setup({
            suggestion = {
                enabled = true,
                auto_trigger = true,
                keymap = {
                    accept = "<Tab>",
                    accept_word = "<C-l>",
                    accept_line = "<C-j>",
                    next = "<M-]>",
                    prev = "<M-[>",
                    dismiss = "<C-]>"
                }
            },
            panel = {
                enabled = false
            }
        })
    end
}}
