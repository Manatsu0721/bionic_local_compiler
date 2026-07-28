#!/bin/bash

cd $HOME/project/gcc-build2  && rm -rf *

$GCC_SRC/configure \
    --build=x86_64-pc-linux-gnu \
    --host=$TARGET \
    --target=$TARGET \
    --prefix=/opt/gcc-4.9 \
    --enable-languages=c,c++ \
    --disable-bootstrap \
    --disable-multilib \
    --disable-libsanitizer \
    --disable-libvtv \
    --disable-libcilkrts \
    --disable-libquadmath \
    --disable-libssp \
    --disable-libitm \
    --disable-libgomp \
    --disable-shared \
    --disable-nls \
    --with-sysroot=$SYSROOT \
    --with-build-sysroot=$SYSROOT \
    --with-linker-hash-style=gnu \
    --with-gmp=$DEP_ROOT \
    --with-mpfr=$DEP_ROOT \
    --with-mpc=$DEP_ROOT \
    --with-ld=$LD \
    --with-ar=$AR \
    --with-ranlib=$RANLIB \
    --with-nm=$NM \
    CC_FOR_BUILD=gcc \
    CXX_FOR_BUILD=g++ \
    CC="$CC" \
    CXX="$CXX" \
    CFLAGS="-O2 -pipe" \
    CXXFLAGS="-O2 -pipe" \
    LDFLAGS="-L$DEP_ROOT/lib -Wl,-rpath-link=$SYSROOT/usr/lib" \
    ac_cv_exeext='' \
    ac_cv_objext='o' \
    lt_cv_dlopen=no \
    ac_cv_func_dlopen=no \
    ac_cv_func_shl_load=no \
    gcc_no_link=no

make -j$(nproc)  CFLAGS="-O2 -pipe  -std=gnu11" \
     CXXFLAGS="-O2 -pipe  -std=gnu++11" \
     GCC_FOR_TARGET=gcc \
     all-gcc
# 如果使用新版本clang构建该GCC，请在CFLAGS CXXFLAGS都加入: -fbracket-depth=512 -Wno-reserved-user-defined-literal
