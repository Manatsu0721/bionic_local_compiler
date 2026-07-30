#!/bin/bash
# 真正的链接器路径（直接使用 NDK 中的 lld）
REAL_LD="${NDK}/toolchains/llvm/prebuilt/linux-x86_64/bin/lld2"

# 若 NDK 环境变量未设置，尝试硬编码（备用）
if [ -z "$NDK" ]; then
    NDK="$HOME/android-ndk-r27d"
    REAL_LD="${NDK}/toolchains/llvm/prebuilt/linux-x86_64/bin/lld2"
fi

# 收集参数，过滤掉 --no-undefined
args=()
for arg in "$@"; do
    if [ "$arg" = "-Wl,--no-undefined" ]; then
        continue
    elif [ "$arg" = "--no-undefined" ]; then
        continue
    else
        args+=("$arg")
    fi
done

# 调用真实链接器，强制追加忽略未定义符号（覆盖前面的任何设置）
exec -a ld.lld "$REAL_LD" "${args[@]}" --unresolved-symbols=ignore-all
