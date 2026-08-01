#!/bin/bash
set -e
cd $HOME/project/llvm-build

cmake -G Ninja ../llvm \
    -DCMAKE_TOOLCHAIN_FILE=$NDK/build/cmake/android.toolchain.cmake \
    -DANDROID_ABI=arm64-v8a \
    -DANDROID_PLATFORM=android-24 \
    -DANDROID_STL=c++_static \
    -DCMAKE_BUILD_TYPE=Release \
    -DLLVM_ENABLE_PROJECTS="clang;lld" \
    -DLLVM_TARGETS_TO_BUILD="AArch64;ARM;X86" \
    -DLLVM_DEFAULT_TARGET_TRIPLE="aarch64-linux-android" \
    -DLLVM_EXTERNAL_CLANG_SOURCE_DIR=../clang \
    -DLLVM_EXTERNAL_LLD_SOURCE_DIR=../lld \
    -DCMAKE_INSTALL_PREFIX=$(pwd)/install \
    -DLLVM_ENABLE_ZLIB=OFF \
    -DLLVM_ENABLE_TERMINFO=OFF \
    -DLLVM_ENABLE_LIBXML2=OFF \
    -DLLVM_NATIVE_CMAKE_FLAGS="-DCMAKE_C_COMPILER=/usr/bin/clang -DCMAKE_CXX_COMPILER=/usr/bin/clang++" \
    -DLLVM_VERSION_MAJOR=9 \
    -DLLVM_VERSION_MINOR=0 \
    -DLLVM_VERSION_PATCH=3 \
    -DCLANG_VENDOR="Android (5484270 based on r353983c) " \
    -DCLANG_REPOSITORY_STRING="https://android.googlesource.com/toolchain/clang" \
    -DCLANG_REVISION="745b335211bb9eadfa6aa6301f84715cee4b37c5" \
    -DLLVM_REPOSITORY_STRING="https://android.googlesource.com/toolchain/llvm" \
    -DLLVM_REVISION="60cf23e54e46c807513f7a36d0a7b777920b5881" \
    -DLLVM_VERSION_SUFFIX="svn" 
      


ninja -j$(nproc)
cmake --install . --prefix $(pwd)/install --strip
# ↑ 如果要保留symtab，请将上面这条命令改为"ninja install"，同时修改ld-wrap.sh，在exec命令末尾添加"-S"。
