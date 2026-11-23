{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ 
    # File Manager
    dolphin

    # For general HEIF container support (this includes the AVIF file format) 
    libheif.bin # provides heif-thumbnailer (the program that generates HEIF thumbnails)
    libheif.out # provides heif.thumbnailer (allows for the viewing of HEIF thumbnails)
    
    # For JXL(JPEG XL) support
    libjxl
    
    # For WebP support
    webp-pixbuf-loader
    
    # For 3D-Model files support
    f3d
                
    kdePackages.kio-extras
    kdePackages.kimageformats
    # support for icons
            kdePackages.qtsvg
  ];
  # All of the thumbnailers are created in '/run/current-system/sw/share/thumbnailers'

  # fix for Open With menu not showing any applications
  environment.etc."xdg/menus/applications.menu".source = "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";

}
