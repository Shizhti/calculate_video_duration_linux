#!/bin/bash

# 检查是否提供了文件夹路径作为参数
if [ $# -eq 0 ]; then
    read -p "请输入要计算视频时长的文件夹路径（多个路径用空格分隔）: " -a folder_paths
else
    folder_paths=("$@")
fi

total_duration=0

# 遍历每个文件夹
for folder_path in "${folder_paths[@]}"; do
    # 检查文件夹是否存在
    if [ ! -d "$folder_path" ]; then
        echo "错误: 文件夹 '$folder_path' 不存在!"
        continue
    fi

    # 遍历文件夹中的所有视频文件
    for file in "$folder_path"/*; do
        if [[ -f "$file" ]]; then
            # 获取视频时长
            duration=$(ffmpeg -i "$file" 2>&1 | grep "Duration" | cut -d ' ' -f 4 | sed s/,//)
            if [ -n "$duration" ]; then
                IFS=: read -r hours minutes seconds <<< "$duration"
                total_duration=$(echo "$total_duration + $hours * 3600 + $minutes * 60 + $seconds" | bc)
            fi
        fi
    done
done

# 计算总时长的小时和分钟
total_hours=$(echo "$total_duration / 3600" | bc)
total_minutes=$(echo "($total_duration % 3600) / 60" | bc)

# 输出总时长
echo "所有文件夹的总时长为: $total_hours 小时 $total_minutes 分钟"
