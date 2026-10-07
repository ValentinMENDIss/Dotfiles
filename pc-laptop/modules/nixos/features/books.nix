{pkgs, ...}:
{
  environment.systemPackages = [
    pkgs.zathura
    pkgs.calibre
  ];
}
