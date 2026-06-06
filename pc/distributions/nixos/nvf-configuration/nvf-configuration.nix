# As this package is separate from configuration module or home-manager, to run/build/compile, you will need to do following in /etc/nixos directory: nix run .
# This config is also runnable on any system seperately from all other config files using: nix run github:username/reponame

{ pkgs, ... }:

{
  vim = {
    vimAlias = true;
    viAlias = true;

    keymaps = [
    {
      key = "<leader>t";
      mode = "n";
      silent = true;
      action = ":NvimTreeToggle<CR>";
     }
    ];

    theme.enable = true;

    lsp = {
      enable = true;
    };

    statusline.lualine.enable = true;
    telescope.enable = true;

    languages = {
      nix.enable = true;
      go.enable = true;
      python.enable = true;
      json.enable = true;

      enableTreesitter = true;
    };

    autocomplete.nvim-cmp.enable = true;
  
    extraPlugins = {
      nvim-tree = {
        package = pkgs.vimPlugins.nvim-tree-lua;
        setup = "require('nvim-tree').setup()";
      };
      render-markdown = {
        package = pkgs.vimPlugins.render-markdown-nvim;
        setup = "require('render-markdown').setup()";
      };
      mini-icons = {
        package = pkgs.vimPlugins.mini-icons;
      };
      which-key = {
        package = pkgs.vimPlugins.which-key-nvim;
      };
      flash = {
        package = pkgs.vimPlugins.flash-nvim;
        setup = '' 
	  require('flash').setup {
	  }
	'';
      };
      fidget = {
        package = pkgs.vimPlugins.fidget-nvim;
        setup = "require('fidget').setup()";
      };
      comment = {
        package = pkgs.vimPlugins.comment-nvim;
        setup = "require('Comment').setup()";
        # 'gcc' = comment line out
      };
    };
  };
  
}
