{pkgs, config,...}:

{
  home.sessionVariables = {
  EDITOR = "nvim";
};

programs.neovim = {
  enable = true;
  # package = pkgs.neovim-nightly;
  vimAlias = true;
  vimdiffAlias = true;
  withNodeJs = true;

  extraPackages = with pkgs; [
	nixd
	lua-language-server
	python312Packages.python-lsp-server
	wl-clipboard
	fd
  ];

  plugins = with pkgs.vimPlugins; [
   lazy-nvim
   which-key-nvim
   nvim-treesitter
	mini-pairs
	mini-surround
	mini-comment
	mini-bracketed
	mini-icons
	nvim-web-devicons
	nvim-lspconfig
	 nvim-cmp
	 fidget-nvim
	telescope-nvim
	telescope-fzf-native-nvim
	neodev-nvim
	telescope-ui-select-nvim
	plenary-nvim
	cmp_luasnip
	cmp-nvim-lsp
	cmp-path
	luasnip
	friendly-snippets
  ];

  extraLuaConfig = ''
    vim.g.mapleader = " " -- Need to set leader before lazy for correct keybindings
	vim.g.maplocalleader = ' '
	vim.o.clipboard = 'unnamedplus'
	vim.o.number = true
	vim.o.relativenumber = true
	vim.o.signcolumn = 'yes'
	vim.o.tabstop = 4
	vim.o.shiftwidth = 4
	vim.o.updatetime = 250
	vim.o.termguicolors = true
	vim.o.mouse = 'a'
	vim.opt.timeoutlen = 300
	vim.opt.undofile = true
	vim.opt.breakindent = true
	vim.opt.showmode = false
	vim.opt.list = true
	vim.opt.inccommand = 'split'
	vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
	vim.opt.cursorline = true
	vim.opt.scrolloff = 10
	vim.opt.hlsearch = true
	require('mini.surround').setup()
	require('mini.pairs').setup()
	require('mini.comment').setup()
	require('mini.ai').setup()
	require('mini.bracketed').setup()

	vim.api.nvim_create_autocmd('TextYankPost', {
	  desc = 'Highlight when yanking (copying) text',
	  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
	  callback = function()
		vim.highlight.on_yank()
	  end,
	})



    require("lazy").setup({
      performance = {
        reset_packpath = false,
        rtp = {
            reset = false,
          }
        },
      dev = {
        path = "${pkgs.vimUtils.packDir config.programs.neovim.finalPackage.passthru.packpathDirs}/pack/myNeovimPackages/start",
      },
      install = {
        -- Safeguard in case we forget to install a plugin with Nix
        missing = false,
      },
      spec = {
        -- Import plugins from lua/plugins
        { import = "plugins" },
      },
    })



  '';
  };
  xdg.configFile."nvim/lua" = {
  recursive = true;
  source = ./lua;
};
}
