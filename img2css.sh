#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

boxSize=1
image="${1:-}"

test -f "$image" || {
    echo "${image}: input file not an image"
    exit 1
}

width=$(identify -format '%w\n' "$image")
outName=$(basename "${image%.*}" | tr -d "'" | tr -d '"')

function genDoc() {
    echo "<link href='./${outName}.css' rel='stylesheet'>"
    echo -e "<body>\n<div class='row'>"
    sed -E 's|#(..)(..)(..)|<div class="x\1\2\3"></div>|' |
        awk -v w="$width" '1;!(NR%w) {print "</div>\n<div class=\"row\">\n"}' |
        grep -v '^$' | uniq -c |
        sed -E "s/^\s+//g; s/^1\s//g;\
            s/([[:digit:]]*) (<div) (class.*)/\2 style='width: \1px' \3/g"
    echo "</body>"
}

function genStyle() {
    rowClass=".row {display: flex; flex-direction: row;}"
    pixelClass=".row > div {width: ${boxSize}px; height:${boxSize}px;}"
    echo -e "$rowClass\n$pixelClass"
    sort -u |
        sed -E 's/#(..)(..)(..)/.x\1\2\3 {background-color: #\1\2\3;}/g'
}

convert "$image" txt: | grep -o '#[A-F0-9]\{6\}' | tee \
    >(genDoc > "$outName".html) \
    >(genStyle > "$outName".css) >/dev/null
