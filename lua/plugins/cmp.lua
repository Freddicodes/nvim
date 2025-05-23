local function setup()
    local cmp = require("cmp")
    local lspkind = require("lspkind")
    local ros_source = require("snippets.ros")

    cmp.setup({
        performance = {
            debounce = 0,
            throttle = 0,
        },
        view = {
            entries = {
                name = "custom",
            },
        },
        formatting = {
            format = function(entry, vim_item)
                local kind = lspkind.cmp_format({
                    mode = "symbol_text",
                    max_width = 50,
                })
                kind = kind(entry, vim_item)
                local strings = vim.split(kind.kind, "%s", { trimempty = true })
                kind.kind = " " .. strings[1] .. " "
                kind.menu = "    (" .. strings[2] .. ")"

                return kind
            end,
        },
        snippet = nil,
        mapping = {
            ["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
            ["<S-Tab>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "s" }),
            ["<CR>"] = cmp.mapping.confirm({ select = true }),
            ["<c-c>"] = cmp.mapping.close(),
            ["<c-n>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
            ["<c-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "s" }),
        },
        window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
        },
        sources = cmp.config.sources({
            { name = "ros" },
            { name = "nvim_lsp" },
            { name = "buffer" },
            { name = "path" },
            { name = "emoji" },
        }),
    })
end

return {
    "hrsh7th/nvim-cmp",
    config = function()
        setup()
    end,
    dependencies = {
        "andersevenrud/cmp-tmux",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-emoji",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-path",
        "onsails/lspkind.nvim",
    },
    event = "BufRead",
}

