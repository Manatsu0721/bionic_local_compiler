#!/bin/bash
export NDK=$HOME/android-ndk-r15c

# export SYSROOT=$NDK/sysroot
export SYSROOT=$NDK/platforms/android-24/arch-arm64

export DEP_ROOT=$HOME/project/deps
export GCC_SRC=$HOME/Desktop/gcc-4.9-src
export BUILD_DIR=$HOME/project/gcc-build2
export PATH=~/project/gcc-wrappers:$NDK/toolchains/aarch64-linux-android-4.9/prebuilt/linux-x86_64/bin:$PATH
export CC=aarch64-linux-android-gcc
export CXX=aarch64-linux-android-g++
export AR=aarch64-linux-android-ar
export RANLIB=aarch64-linux-android-ranlib
export NM=aarch64-linux-android-nm
export LD=aarch64-linux-android-ld.gold
export CPPFLAGS="-I$DEP_ROOT/include"
export LDFLAGS="-L$DEP_ROOT/lib"
export LIBS="-lmpc -lmpfr -lgmp"

cd $HOME/project/gcc-build2  && rm -rf *

$GCC_SRC/configure     --build=x86_64-pc-linux-gnu     --host=aarch64-linux-android     --target=aarch64-linux-android     --prefix=/opt/gcc-4.9     --enable-languages=c,c++     --disable-bootstrap     --disable-multilib     --disable-libsanitizer     --disable-libvtv     --disable-libcilkrts     --disable-libquadmath     --disable-libssp     --disable-libitm     --disable-libgomp     --disable-shared     --disable-nls     --with-sysroot=$SYSROOT     --with-gmp=$DEP_ROOT     --with-mpfr=$DEP_ROOT     --with-mpc=$DEP_ROOT     --with-ld=$NDK/toolchains/aarch64-linux-android-4.9/prebuilt/linux-x86_64/bin/$LD     --with-ar=$AR     --with-ranlib=$RANLIB     --with-nm=$NM     CC_FOR_BUILD=gcc     CXX_FOR_BUILD=g++     CC="aarch64-linux-android-gcc --sysroot=$SYSROOT"     CXX="aarch64-linux-android-g++ --sysroot=$SYSROOT"     CFLAGS="-O2 -pipe"     CXXFLAGS="-O2 -pipe"     LDFLAGS="-L$DEP_ROOT/lib -Wl,-rpath-link=$SYSROOT/usr/lib"

make -j4