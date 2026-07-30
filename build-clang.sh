#!/bin/bash
set -e
cd $HOME/project/llvm-build
# 修复 MicrosoftDemangleNodes.h 缺失的头文件
sed -i '1i#include <cstdint>\n#include <string>' $HOME/project/llvm/include/llvm/Demangle/MicrosoftDemangleNodes.h

cmake -G Ninja ../llvm \
    -DCMAKE_TOOLCHAIN_FILE=$NDK/build/cmake/android.toolchain.cmake \
    -DANDROID_ABI=arm64-v8a \
    -DANDROID_PLATFORM=android-24 \
    -DANDROID_STL=c++_static \
    -DCMAKE_BUILD_TYPE=Release \
    -DLLVM_ENABLE_PROJECTS="clang;lld" \
    -DLLVM_TARGETS_TO_BUILD="AArch64;ARM;X86" \
    -DLLVM_EXTERNAL_CLANG_SOURCE_DIR=../clang \
    -DLLVM_EXTERNAL_LLD_SOURCE_DIR=../lld \
    -DCMAKE_INSTALL_PREFIX=$(pwd)/install \
    -DLLVM_ENABLE_ZLIB=OFF \
    -DLLVM_ENABLE_TERMINFO=OFF \
    -DLLVM_ENABLE_LIBXML2=OFF \
    -DLLVM_NATIVE_CMAKE_FLAGS="-DCMAKE_C_COMPILER=/usr/bin/clang -DCMAKE_CXX_COMPILER=/usr/bin/clang++"

ninja -j$(nproc)
ninja install
