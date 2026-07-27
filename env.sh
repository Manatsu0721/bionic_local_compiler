
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