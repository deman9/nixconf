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
	gcc
  ];

  plugins = with pkgs.vimPlugins; [
   lazy-nvim
   gitsigns-nvim
   which-key-nvim
   onenord-nvim
   nvim-treesitter
   conform-nvim
   blink-cmp
	mini-pairs
	mini-ai
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
	nvim-lint
	  nvim-treesitter-context
	  nvim-ts-autotag
	  nvim-treesitter-textobjects
	  nvim-treesitter.withAllGrammars
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
	vim.opt.showmode = true
	vim.opt.list = true
	vim.opt.inccommand = 'split'
	vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
	vim.opt.cursorline = true
	vim.opt.scrolloff = 10
	vim.opt.hlsearch = true
	vim.lsp.enable({"nixd", "lua_ls"})
	require('mini.surround').setup()
	require('mini.pairs').setup()
	require('mini.comment').setup()
	require('mini.ai').setup()
	require('mini.bracketed').setup()

	vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
	vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
	vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
	vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
	vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
	vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
	vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

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
