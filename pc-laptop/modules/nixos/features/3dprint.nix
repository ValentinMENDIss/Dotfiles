{unstable, pkgs, ...}:
{
  environment.systemPackages = [
    unstable.orca-slicer    
    pkgs.freecad
  ];
}
