#!/bin/sh

TARGET_DIR="$HOME/Documents/Yazi"

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup update

git clone "https://github.com/sxyazi/yazi.git" "$TARGET_DIR"
cd yazi
cargo build --release

