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

make -j$(nproc)  CFLAGS="-O2 -pipe -Wno-reserved-user-defined-literal -fbracket-depth=512 -std=gnu11" \
     CXXFLAGS="-O2 -pipe -Wno-reserved-user-defined-literal -fbracket-depth=512 -std=gnu++14" \
     GCC_FOR_TARGET=gcc \
     all-gcc
