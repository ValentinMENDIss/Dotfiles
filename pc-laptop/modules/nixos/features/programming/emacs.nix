{ pkgs, lib, config, ... }: 
{
  options.mendiss.modules.programming = {
    emacs = {
      enable = lib.mkEnableOption "Enables Emacs-Setup Module";
    };
  };

  config = lib.mkIf config.mendiss.modules.programming.emacs.enable {
    environment.systemPackages = with pkgs; [
      emacs
      ripgrep
      coreutils
      fd
      clang
    ];
  };

}
