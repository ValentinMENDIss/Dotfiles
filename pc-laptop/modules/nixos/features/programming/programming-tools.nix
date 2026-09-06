{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    clang
    clang-tools
    docker
    docker-compose
    android-tools
  ];
}
