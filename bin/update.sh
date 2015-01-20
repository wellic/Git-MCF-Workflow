#!/bin/bash

set -e

SRC="$HOME/.gitconfig"
DST="../.gitconfig_sample"

echo cp "$SRC" "$DST"
cp "$SRC" "$DST"
sed 's/Valerii Savchenko.*$/your_name/g' -i "$DST"
sed 's/valerii.s\@.*$/your@mail/g' -i "$DST"
sed 's/wellic/yournik/g' -i "$DST"


