{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    emacs
    ripgrep
    coreutils
    fd
    clang
  ];
}
