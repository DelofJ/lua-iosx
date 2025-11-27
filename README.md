## LUA 5.3.5 for iOS

This repo provides a universal script for building static LUA library for use in iOS applications.\
The latest supported LUA version is taken from: https://www.lua.org/ftp/lua-5.3.5.tar.gz\

## Prerequisites
  1) ```xcode-select -p``` must point to Xcode app developer directory (by default e.g. /Applications/Xcode.app/Contents/Developer). If it points to CommandLineTools directory you should execute:
  ```sudo xcode-select --reset``` or ```sudo xcode-select -s /Applications/Xcode.app/Contents/Developer```
  
## How to build?
```
git clone https://github.com/DelofJ/lua-iosx
cd lua-iosx
./build.sh
```
The resulting library will be located at `lua/out/liblua.a`
