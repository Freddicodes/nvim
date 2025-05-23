local function on_attach(_client, bufnr)
    local opts = { noremap = true, silent = true, buffer = bufnr }
    local set_keymap = vim.keymap.set

    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    set_keymap("n", "gd", vim.lsp.buf.definition, opts)
    set_keymap("n", "gr", vim.lsp.buf.rename, opts)
    set_keymap("n", "gR", vim.lsp.buf.references, opts)
    set_keymap("n", "bf", vim.lsp.buf.format, opts)
    set_keymap("n", "K", vim.lsp.buf.hover, opts)
    set_keymap("n", "gl", vim.diagnostic.setloclist, opts)
end

local function setup()
    local lspconfig = require("lspconfig")

    vim.diagnostic.config({ virtual_text = false })
    -- Set up border for floating preview windows
    -- source: https://github.com/neovim/nvim-lspconfig/wiki/UI-customization
    local border = {
        { "╭", "FloatBorder" },
        { "─", "FloatBorder" },
        { "╮", "FloatBorder" },
        { "│", "FloatBorder" },
        { "╯", "FloatBorder" },
        { "─", "FloatBorder" },
        { "╰", "FloatBorder" },
        { "│", "FloatBorder" },
    }

    local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview

    function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
        opts.border = border
        return orig_util_open_floating_preview(contents, syntax, opts, ...)
    end

    -- finding new lsps to configure --> RUN: ':help lspconfig-all' and search for your lang

    lspconfig.pylsp.setup({
        on_attach = on_attach,
        settings = {
            pylsp = {
                plugins = {
                    pycodestyle = {
                        enabled = true,
                        maxLineLength = 120,
                    },
                },
            },
        },
    })
    lspconfig.lua_ls.setup({ on_attach = on_attach })
    -- lspconfig.tailwindcss.setup({ on_attach = on_attach })
    -- lspconfig.ts_ls.setup({ on_attach = on_attach })
    -- lspconfig.html.setup({ on_attach = on_attach })
    -- lspconfig.cssls.setup({ on_attach = on_attach })
end

return {
    "neovim/nvim-lspconfig",
    config = function()
        setup()
    end,
    event = "BufRead",
}

