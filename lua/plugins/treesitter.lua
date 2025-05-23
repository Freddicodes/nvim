local function setup()
    require("nvim-treesitter.configs").setup({
        ensure_installed = {
            "bash",
            "c",
            "comment",
            "dockerfile",
            "editorconfig",
            "git_config",
            "gitignore",
            "go",
            "hcl",
            "html",
            "htmldjango",
            "javascript",
            "json",
            "latex",
            "lua",
            "make",
            "markdown",
            "markdown_inline",
            "python",
            "rst",
            "rust",
            "ssh_config",
            "terraform",
            "tmux",
            "toml",
            "typescript",
            "yaml",
        },
        highlight = {
            enable = true,
            disable = function(lang, buf)
                local max_filesize = 100 * 1024 -- 100 KB
                local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                if ok and stats and stats.size > max_filesize then
                    return true
                end
            end,
            additional_vim_regex_highlighting = false,
        }
    })
end

return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
        "windwp/nvim-ts-autotag",
    },
    config = function()
        setup()
    end,
}
