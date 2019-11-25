#!/usr/bin/env bash

set -eux

if [ -d /root/.cabal ] ; then
    cp -a /root/.cabal $HOME
fi

if [ -d /root/.ghcup ] ; then
    cp -a /root/.ghcup $HOME
fi

if [ $(whoami) = "root" ] ; then
    luaotfload-tool -vvv --update
fi

cabal v2-configure -O1 --disable-documentation --write-ghc-environment-files=ghc8.4.4+

./Shakefile.hs
./Shakefile.hs clean
