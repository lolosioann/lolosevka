#!/bin/sh
# Install the latest Lolosevka release for the current user:
#   wget -qO- https://raw.githubusercontent.com/lolosioann/lolosevka/main/install.sh | sh
set -e
URL=https://github.com/lolosioann/lolosevka/releases/latest/download/Lolosevka-TTF.tar.gz
DIR="${XDG_DATA_HOME:-$HOME/.local/share}/fonts/lolosevka"

rm -rf "$DIR" # drop files from older releases
mkdir -p "$DIR"
wget -qO- "$URL" | tar -xz -C "$DIR"
fc-cache -f "$DIR"
echo "Installed Lolosevka to $DIR"
