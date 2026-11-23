{ pkgs, ... }:

{
  environment.systemPackages = [ 
    # File Manager
    pkgs.dolphin

    # For general HEIF container support (this includes the AVIF file format) 
    pkgs.libheif.bin # provides heif-thumbnailer (the program that generates HEIF thumbnails)
    pkgs.libheif.out # provides heif.thumbnailer (allows for the viewing of HEIF thumbnails)
    
    # For JXL(JPEG XL) support
    pkgs.libjxl
    
    # For WebP support
    pkgs.webp-pixbuf-loader
    
    # For 3D-Model files support
    pkgs.f3d
                
    pkgs.kdePackages.kio-extras
    pkgs.kdePackages.kimageformats
    # support for icons
    pkgs.kdePackages.qtsvg
  ];
  # All of the thumbnailers are created in '/run/current-system/sw/share/thumbnailers'

  # fix for Open With menu not showing any applications
  environment.etc."xdg/menus/applications.menu".source = "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";

}
