#!/bin/bash

if [[ -z $1 ]]; then
    echo You must pass a .spk in as the first argument
    exit 1
fi

set -euo pipefail
test -e $1 || (echo $1 does not exist; exit 1)
cp $1 . || echo $1 already copied. moving on
SPK_PACKAGE_NAME=$(basename $1)

THIS_DIR=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")

cd "$THIS_DIR"

SPK_PACKAGE_ID=$(echo `sha256sum $1 | head -c 32`)

cp index.html.tmpl index.html
sed "s/SPK_PACKAGE_NAME/$SPK_PACKAGE_NAME/g" -i index.html
sed "s/SPK_PACKAGE_ID/$SPK_PACKAGE_ID/g" -i index.html
