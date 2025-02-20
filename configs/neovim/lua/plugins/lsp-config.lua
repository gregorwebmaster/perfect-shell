return {
    -- Ensure `npm` and `go` are available in PATH
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "intelephense",
                    "pyright",
                    "dockerls",
                    "docker_compose_language_service",
                    "bashls",
                    "tsserver",
                    "dartls",
                    "gopls",
                    "jsonls",
                },
                automatic_installation = true,
            })
        end
    },
    {
        "b0o/schemastore.nvim",
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")

            lspconfig.lua_ls.setup({
                settings = {
                    Lua = {
                        runtime = {
                            version = 'LuaJIT',
                        },
                        diagnostics = {
                            globals = {'vim'},
                        },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false,
                        },
                        telemetry = {
                            enable = false,
                        },
                    }
                }
            })

            lspconfig.intelephense.setup({})

            lspconfig.pyright.setup({})

            lspconfig.dockerls.setup({})

            lspconfig.docker_compose_language_service.setup({})

            lspconfig.bashls.setup({
                filetypes = { "sh", "bash" },
            })

            lspconfig.tsserver.setup({
                on_attach = function(client)
                    client.server_capabilities.documentFormattingProvider = false
                    client.server_capabilities.documentRangeFormattingProvider = false
                end,
            })

            lspconfig.dartls.setup({
                cmd = { "dart", "language-server", "--protocol=lsp" },
                filetypes = { "dart" },
                root_dir = lspconfig.util.root_pattern("pubspec.yaml"),
            })

            lspconfig.gopls.setup({
                settings = {
                    gopls = {
                        analyses = {
                            unusedparams = true,
                        },
                        staticcheck = true,
                    }
                }
            })

            lspconfig.jsonls.setup({
                settings = {
                    json = {
                        schemas = require("schemastore").json.schemas(),
                        validate = { enable = true },
                    }
                }
            })
        end
    },
    {
        "hrsh7th/nvim-cmp",
        requires = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "saadparwaiz1/cmp_luasnip",
            "L3MON4D3/LuaSnip",
        },
        config = function()
            local cmp = require'cmp'
            local luasnip = require'luasnip'

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                }, {
                    { name = 'buffer' },
                    { name = 'path' },
                })
            })

            cmp.setup.cmdline({ '/', '?' }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' }
                }
            })

            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' }
                }, {
                    { name = 'cmdline' }
                })
            })
        end
    },
    {
        "L3MON4D3/LuaSnip",
        config = function()
            require("luasnip").config.set_config({
                history = true,
                updateevents = "TextChanged,TextChangedI",
            })
        end
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        requires = { "nvim-lua/plenary.nvim" },
        config = function()
            local null_ls = require("null-ls")

            null_ls.setup({
                sources = {
                    null_ls.builtins.formatting.prettier,
                    null_ls.builtins.formatting.black,
                    null_ls.builtins.formatting.stylua,
                    null_ls.builtins.formatting.gofmt,
                    null_ls.builtins.formatting.phpcsfixer,
                    null_ls.builtins.formatting.json_tool,
                    null_ls.builtins.diagnostics.eslint,
                    null_ls.builtins.diagnostics.flake8,
                    null_ls.builtins.diagnostics.phpstan,
                },
                on_attach = function(client)
                    if client.server_capabilities.documentFormattingProvider then
                        vim.api.nvim_exec([[
                            augroup LspFormatting
                                autocmd! * <buffer>
                                autocmd BufWritePre <buffer> lua vim.lsp.buf.format()
                            augroup END
                        ]], false)
                    end
                end,
            })
        end
    },
}

