#!/bin/bash

# 修复 MicrosoftDemangleNodes.h 缺失的头文件
sed -i '1i#include <cstdint>\n#include <string>' $HOME/project/llvm/include/llvm/Demangle/MicrosoftDemangleNodes.h
# 补丁：去除 NDK cmake 配置的强制 -Wl,--no-undefined 机制
cp -r $HOME/project/bionic_local_compiler/patch/ $HOME/
mv $NDK/toolchains/llvm/prebuilt/linux-x86_64/bin/lld $NDK/toolchains/llvm/prebuilt/linux-x86_64/bin/lld2
cp $HOME/project/bionic_local_compiler/ld-wrap.sh $NDK/toolchains/llvm/prebuilt/linux-x86_64/bin/lld
chmod +x $NDK/toolchains/llvm/prebuilt/linux-x86_64/bin/lld
