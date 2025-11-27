#!/bin/bash
set -e

LUA_VER=5.3.5

XCODE_ROOT=$( xcode-select -print-path )
ISYSROOT=$XCODE_ROOT/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk
CC="clang -std=gnu99 -fembed-bitcode -arch arm64 -isysroot $ISYSROOT -mios-version-min=13.4"

if [ ! -f lua-$LUA_VER.tar.gz ]; then
    curl -L https://www.lua.org/ftp/lua-$LUA_VER.tar.gz -o lua-$LUA_VER.tar.gz
fi
if [ ! -d lua ]; then
    echo "extracting lua-$LUA_VER.tar.gz ..."
    tar -xf lua-$LUA_VER.tar.gz
    mv lua-$LUA_VER lua
fi

echo "Patching lua-$LUA_VER"
if [ ! -f lua/src/loslib.c.orig ]; then
  cp -f lua/src/loslib.c lua/src/loslib.c.orig
else
  cp -f lua/src/loslib.c.orig lua/src/loslib.c
fi
patch -p0 <loslib.c.patch

cd lua/src
gmake a SYSCFLAGS="-DLUA_USE_MACOSX -DIOS_BUILD -DLUA_USE_READLINE" SYSLIBS="-lreadline" CC="$CC"
cd ../..
mkdir lua/out
mv lua/src/liblua.a lua/out