#!/bin/sh
git config filter.utf16le.clean "iconv -f utf-16le -t utf-8"
git config filter.utf16le.smudge "iconv -f utf-8 -t utf-16le"
git config filter.utf16le.required true

# checkout file as utf-16
if [ -f ./ollydbg.lng ]; then
    rm ollydbg.lng
    git checkout -- ollydbg.lng
fi
