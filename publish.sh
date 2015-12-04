#!/bin/bash

if [[ -z $1 ]]; then
    echo You must pass a .spk in as the first argument
    exit 1
fi

if [[ -z $2 ]]; then
    echo You must pass a davros url as the 2nd parameter
    exit 1
fi

set -euo pipefail
THIS_DIR=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
cd "$THIS_DIR"

rm ./*spk
./gen_index.sh "$1"
PASS=$(echo "$2" | python -c "import sys; s=sys.stdin.read(); print s.split(':')[2].split('@')[0]")
rm .csync*
owncloudcmd -u sandstorm -p "$PASS"  --non-interactive . $2
