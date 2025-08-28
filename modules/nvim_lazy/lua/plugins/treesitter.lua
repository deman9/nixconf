return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			auto_install = false,
			ensure_installed = {},
		},
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				highlight = {
					enable = {},
				},
			})
		end,
	},
}
