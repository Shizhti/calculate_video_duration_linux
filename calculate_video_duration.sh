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
            echo "用法: $0 [选项] [文件夹路径...]"
            echo "计算指定文件夹中视频文件的总时长。"
            echo "选项:"
            echo "  -r        递归处理子目录中的视频文件"
            echo "  -a        包含隐藏文件和文件夹中的视频"
            echo "  -p, --pwd 计算当前目录下的视频时长"
            echo "  -h, --help 显示本帮助信息"
            echo "如果没有提供文件夹路径，程序会提示输入。"
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
    read -p "请输入要计算视频时长的文件夹路径（多个路径用空格分隔）: " -a folder_paths
fi

total_duration=0  # 总时长（秒）

# 遍历每个文件夹
for folder_path in "${folder_paths[@]}"; do
    if [ ! -d "$folder_path" ]; then
        echo "错误: 文件夹 '$folder_path' 不存在!"
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

# 转换为小时和分钟（兼容浮点计算）
total_hours=$(echo "$total_duration / 3600" | bc -l | awk '{printf "%d", $0}')
remaining_seconds=$(echo "$total_duration % 3600" | bc -l)
total_minutes=$(echo "$remaining_seconds / 60" | bc -l | awk '{printf "%d", $0}')

echo "所有视频总时长为: $total_hours 小时 $total_minutes 分钟"
