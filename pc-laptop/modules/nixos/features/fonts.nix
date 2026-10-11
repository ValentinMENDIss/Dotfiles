{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
        (google-fonts.override {
                fonts = [ 
                                "Cormorant Garamond" 
                                "Libre Baskerville" 
                                "Special Elite" 
                                "Caprasimo" 
                                "Dawning of a New Day" 
                                "Space Mono" 
                                "Doto" 
                                "Montserrat"
                                "Outfit"
                ];
        })
  ];
}

