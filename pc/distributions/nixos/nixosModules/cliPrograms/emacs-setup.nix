{ pkgs, lib, config, ... }: 
{

  options.mendiss.modules = {
    emacs = {
      enable = lib.mkEnableOption "Enables Emacs-Setup Module";
    };
  };

  config = lib.mkIf config.mendiss.modules.emacs.enable {
    environment.systemPackages = with pkgs; [
      emacs
      ripgrep
      coreutils
      fd
      clang
    ];
  };

}
