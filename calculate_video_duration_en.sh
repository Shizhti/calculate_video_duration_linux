#!/bin/bash

recursive=0
include_hidden=0
folder_paths=()
use_pwd=0

# 解析命令行参数
while [[ $# -gt 0 ]]; do
    case "$1" in
        -r)
            recursive=1
            shift
            ;;
        -a)
            include_hidden=1
            shift
            ;;
        -p|--pwd)
            use_pwd=1
            shift
            ;;
        -h|--help)
            echo "Usage: $0 [options] [folder paths...]"
            echo "Calculate total duration of video files in specified folders."
            echo "Options:"
            echo "  -r        Process subdirectories recursively"
            echo "  -a        Include hidden files and folders"
            echo "  -p, --pwd Calculate duration in current directory"
            echo "  -h, --help Show this help message"
            echo "If no folder paths are provided, the script will prompt for input."
            exit 0
            ;;
        *)
            folder_paths+=("$1")
            shift
            ;;
    esac
done

# 如果使用了-p/--pwd参数，设置当前目录为路径
if [ $use_pwd -eq 1 ]; then
    folder_paths=("$(pwd)")
fi

# 若未提供路径且未使用-p参数，提示用户输入
if [ ${#folder_paths[@]} -eq 0 ] && [ $use_pwd -eq 0 ]; then
    read -p "Enter folder path(s) to calculate video duration (separate with spaces): " -a folder_paths
fi

total_duration=0  # 总时长（秒）

# 遍历每个文件夹
for folder_path in "${folder_paths[@]}"; do
    if [ ! -d "$folder_path" ]; then
        echo "Error: Folder '$folder_path' does not exist!"
        continue
    fi

    # 动态构建find参数
    find_args=("$folder_path")
    if [ $recursive -eq 0 ]; then
        find_args+=(-maxdepth 1)
    fi
    find_args+=(-type f)
    if [ $include_hidden -eq 0 ]; then
        find_args+=(-not -path '*/.*')
    fi

    # 收集文件列表（处理文件名中的空格和特殊字符）
    files=()
    while IFS= read -r -d '' file; do
        files+=("$file")
    done < <(find "${find_args[@]}" -print0 2>/dev/null)

    # 处理每个文件
    for file in "${files[@]}"; do
        duration=$(ffmpeg -i "$file" 2>&1 | grep "Duration" | cut -d ' ' -f 4 | sed s/,//)
        if [ -n "$duration" ]; then
            IFS=: read -r hours minutes seconds <<< "$duration"
            # 计算总秒数并累加（兼容浮点秒数）
            total_duration=$(echo "$total_duration + $hours*3600 + $minutes*60 + $seconds" | bc -l)
        fi
    done
done

# 转换为小时和分钟（修复负数分钟问题）
total_hours=$(echo "$total_duration / 3600" | bc | cut -d. -f1)
remaining_seconds=$(echo "$total_duration - ($total_hours * 3600)" | bc)
total_minutes=$(echo "($remaining_seconds + 0.5) / 60" | bc)  # 加0.5实现四舍五入

# 确保分钟数不会为负数
if [ "$total_minutes" -lt 0 ]; then
    total_minutes=0
fi

echo "Total duration of all videos: $total_hours hours $total_minutes minutes"
