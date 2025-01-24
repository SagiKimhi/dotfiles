-- -----------------------------------------------------------------------------
-- Mason LSP Config - Must come before lspconfig
-- -----------------------------------------------------------------------------

require('mason').setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})
require('mason-lspconfig').setup({
    -- Replace the language servers listed here
    -- with the ones you want to install
    ensure_installed = { 'lua_ls', 'rust_analyzer' },
    handlers = {

        -- Function for setting up default handlers, i.e. an lsp with no custom
        -- handler defined explicitly.

        function(server_name)
            require('lspconfig')[server_name].setup({
            })
        end,

        lua_ls = function()
            require('lspconfig').lua_ls.setup({
                settings = {
                    Lua = {
                        runtime = {
                            version = 'LuaJIT',
                        },
                        diagnostics = {
                            globals = { 'vim' },
                        },
                        workspace = {
                            library = { vim.env.VIMRUNTIME },
                        },
                    },
                },
            })
        end,

        -- sqls = function()
        --     local util = require('lspconfig.util')
        --     require('lspconfig').sqls.setup({
        --         on_attach = function(client, bufnr)
        --             require('sqls').on_attach(client, bufnr)
        --         end,
        --         filetypes = { 'sql' },
        --         cmd = { "sqls", "--config", "/home/skimhi/.config/sqls/config.yml" },
        --         root_dir = function(fname)
        --             return require('lspconfig.util').find_git_ancestor(fname)
        --         end,
        --         settings = {
        --             sqls = {
        --                 connections = {
        --                     {
        --                         driver = 'postgresql',
        --                         dataSourceName = ''
        --                             .. 'host=127.0.0.1'
        --                             .. ' port=' .. os.getenv("PGPORT")
        --                             .. ' user=' .. os.getenv("USER")
        --                             .. ' dbname=' .. os.getenv("USER")
        --                             .. ' password=' .. '' or os.getenv("PGPASSWORD"),
        --                     },
        --                 },
        --             },
        --         },
        --         -- filetypes = { 'sql', 'plpgsql' },
        --         -- single_file_support = true,
        --         -- root_dir = function()
        --         --     require("lspconfig.util").root_pattern('.sqls.yml')
        --         -- end,
        --     })
        -- end,
        --
        -- postgres_lsp = function()
        --     -- local util = require('lspconfig.util')
        --     -- local lspconfig = require('lspconfig')
        --     require('lspconfig').postgres_lsp = {
        --         default_config = {
        --             name = 'postgres_lsp',
        --             cmd = { 'postgres_lsp' },
        --             filetypes = { 'sql' },
        --             single_file_support = true,
        --             root_dir = require('lspconfig.util').root_pattern('root-file.txt'),
        --         },
        --     }
        --     -- lspconfig.postgres_lsp.setup { force_setup = true }
        -- end,

    }
})

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
    vim.lsp.handlers.hover,
    { border = 'rounded' }
)

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    { border = 'rounded' }
)

-- -----------------------------------------------------------------------------
-- Cmp Mappings
-- -----------------------------------------------------------------------------

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ['<Up>']      = cmp.mapping.select_prev_item(cmp_select),
        ['<Down>']    = cmp.mapping.select_next_item(cmp_select),
        ['<Del>']     = cmp.mapping.abort(),
        ['<Left>']    = cmp.mapping.abort(),
        ['<CR>']      = cmp.mapping.confirm({
            select = true,
            behavior = cmp.ConfirmBehavior.Replace,
        }),
        ['<S-NL>']    = cmp.mapping.confirm({
            select = false,
            behavior = cmp.ConfirmBehavior.Insert,
        }),
        ['<Right>']   = cmp.mapping.confirm({
            select = false,
            behavior = cmp.ConfirmBehavior.Replace,
        }),
        ['<C-Space>'] = cmp.mapping.complete(),

        -- navigate to the next snippet placeholder
        ['<C-w>']     = cmp.mapping(function(fallback)
            local snip = require('luasnip')
            if snip.jumpable(1) then
                snip.jump(1)
            else
                fallback()
            end
        end, { 'i', 's' }),
        -- navigate to the previous snippet placeholder
        ['<C-b>']     = cmp.mapping(function(fallback)
            local snip = require('luasnip')
            if snip.jumpable(-1) then
                snip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),
    experimental = {
        ghost_text = true
    },
    view = {
        docs = {
            auto_open = true,
        }
    },
    window = {
        documentation = cmp.config.window.bordered(),
    },
    sources = {
        { name = 'nvim_lsp', group_index = 1 },
        { name = 'buffer',   group_index = 2 },
        { name = 'luasnip',  group_index = 3 },
    },
    snippet = {
        expand = function(args)
            vim.snippet.expand(args.body)
        end,
    },
    formatting = {
        fields = { 'abbr', 'menu', 'kind' },
        format = function(entry, item)
            local n = entry.source.name
            if n == 'nvim_lsp' then
                item.menu = '[LSP]'
            else
                item.menu = string.format('[%s]', n)
            end
            return item
        end,
    },
})

vim.diagnostic.config({
    virtual_text = false,
    severity_sort = true,
    float = {
        style = 'minimal',
        border = 'rounded',
        header = '',
        prefix = '',
    },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '✘',
            [vim.diagnostic.severity.WARN] = '▲',
            [vim.diagnostic.severity.HINT] = '⚑',
            [vim.diagnostic.severity.INFO] = '»',
        },
    },
})

-- -----------------------------------------------------------------------------
-- Keymap Config
-- -----------------------------------------------------------------------------

local defaults = require('lspconfig').util.default_config

defaults.capabilities = vim.tbl_deep_extend(
    'force',
    defaults.capabilities,
    require('cmp_nvim_lsp').default_capabilities(),
    {
        textDocument = {
            foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true
            },
        }
    }
)

vim.o.signcolumn = 'yes'
vim.o.foldenable = true
vim.o.foldcolumn = '1'
-- vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99

require('ufo').setup({})
-- require('luasnip.loaders.from_vscode').lazy_load()

vim.keymap.set('n', 'zR', function() require('ufo').openAllFolds() end)
vim.keymap.set('n', 'zM', function() require('ufo').closeAllFolds() end)

vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
        local opts = { buffer = event.buf }

        vim.keymap.set('i', '<C-h>', function() vim.lsp.buf.signature_help() end, opts)
        vim.keymap.set({ 'n', 'x' }, '<leader>f', function() vim.lsp.buf.format() end, opts)

        vim.keymap.set('n', 'd]', function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set('n', 'd[', function() vim.diagnostic.goto_prev() end, opts)
        vim.keymap.set('n', '<F2>', function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set('n', '<F3>', function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set('n', '<leader>ca', function() vim.lsp.buf.code_action() end, opts)

        vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set('n', 'H', function() vim.lsp.buf.signature_help() end, opts)
        vim.keymap.set('n', 'gd', ':Telescope lsp_definitions<cr>', opts)

        vim.keymap.set('n', '<leader>ma', function() vim.lsp.buf.add_workspace_folder() end, opts)
        vim.keymap.set('n', '<leader>md', function() vim.lsp.buf.remove_workspace_folder() end, opts)
        vim.keymap.set('n', '<leader>ls', function() vim.lsp.buf.list_workspace_folders() end, opts)

        vim.keymap.set('n', 'gT', function() vim.lsp.buf.typehierarchy("supertypes") end, opts)
        vim.keymap.set('n', '<leader>gT', function() vim.lsp.buf.typehierarchy("subtypes") end, opts)

        vim.keymap.set('n', 'gci', '<cmd>Telescope lsp_incoming_calls<cr>', opts)
        vim.keymap.set('n', 'gco', '<cmd>Telescope lsp_outgoing_calls<cr>', opts)
        vim.keymap.set("n", "<leader>vd", "<cmd>Telescope diagnostics<cr>", opts)
        vim.keymap.set('n', '<leader>gr', '<cmd>Telescope lsp_references<cr>', opts)
        vim.keymap.set('n', '<leader>gd', '<cmd>Telescope lsp_definitions<cr>', opts)
        vim.keymap.set('n', '<leader>gt', '<cmd>Telescope lsp_type_definitions<cr>', opts)
        vim.keymap.set("n", "<leader>vs", "<cmd>Telescope lsp_document_symbols<cr>", opts)
        vim.keymap.set('n', '<leader>ws', '<cmd>Telescope lsp_workspace_symbols<cr>', opts)
        vim.keymap.set('n', '<leader>wd', "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", opts)
    end,
})
