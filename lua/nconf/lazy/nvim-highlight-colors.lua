return {
	"brenoprata10/nvim-highlight-colors",
	event = { "BufReadPre", "BufNewFile" }, -- Load when opening files
	config = function()
		require("nvim-highlight-colors").setup({
			render = "background", -- or "foreground" or "virtual"
			enable_named_colors = true,
			enable_tailwind = false,
		})
	end,
}
