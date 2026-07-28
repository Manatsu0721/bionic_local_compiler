#!/bin/bash
cd $HOME/project/deps-src

cd gmp-6.2.1
./configure --host=$TARGET --prefix=$DEP_ROOT     CC=$CC     CXX=$CXX     AR=$AR     RANLIB=$RANLIB \
    CFLAGS="-O2  -ffunction-sections -fdata-sections"
make -j$(nproc)  
make install

cd ..
cd mpfr-4.2.1
./configure --host=$TARGET --prefix=$DEP_ROOT     CC=$CC     CXX=$CXX     AR=$AR     RANLIB=$RANLIB \
    CFLAGS="-O2  -ffunction-sections -fdata-sections" --with-gmp=$DEP_ROOT
make -j$(nproc)  
make install
cd ..

# 此处mpc.h已打过补丁，详见 bionic_local_compiler/deps-patched 和 build.yaml: (- name: Clone files - Prepare GCC source)
cd mpc-1.3.0
./configure --host=$TARGET --prefix=$DEP_ROOT     CC=$CC     CXX=$CXX     AR=$AR     RANLIB=$RANLIB \
    CFLAGS="-O2  -ffunction-sections -fdata-sections" --with-gmp=$DEP_ROOT --with-mpfr=$DEP_ROOT
make -j$(nproc)  
make install
