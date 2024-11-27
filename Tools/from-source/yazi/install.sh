#!/bin/sh

TARGET_DIR="$HOME/Documents/Yazi"

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup update

cargo install --locked yazi-fm yazi-cli
