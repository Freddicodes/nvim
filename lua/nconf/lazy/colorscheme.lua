return {
	"tomasiser/vim-code-dark",
	lazy = false,    -- Load immediately (not lazily)
	priority = 1000, -- Load before other plugins
	config = function()
		vim.cmd.colorscheme("codedark")
	end,
}
