# configuration.nix
{ pkgs, ... }:

{
  environment.systemPackages = [ 
    # For general HEIF container support (this includes the AVIF file format) 
    pkgs.libheif.bin # provides heif-thumbnailer (the program that generates HEIF thumbnails)
    pkgs.libheif.out # provides heif.thumbnailer (allows for the viewing of HEIF thumbnails)

    # For more newer AVIF specific support usually not needed if libheif is installed
    pkgs.libavif
    
    # For JXL(JPEG XL) support
    pkgs.libjxl
    
    # For WebP support
    pkgs.webp-pixbuf-loader
    
    # For 3D-Model files support
    pkgs.f3d
  ];
  # All of the thumbnailers are created in '/run/current-system/sw/share/thumbnailers'
}
