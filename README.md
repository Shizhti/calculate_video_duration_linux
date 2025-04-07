# Linux下视频时长计算器
计算某文件夹下视频总计时长

依赖：`ffmpeg` `find`
# 使用前
Step 1: 下载脚本

Step 2: 给予执行权限
```bash
chmod +x calculate_video_duration.sh
```
# 如何使用

## 直接使用
```bash
./calculate_video_duration.sh
```

```bash
./calculate_video_duration.sh -h
用法: /home/xxx/calculate_video_duration.sh [选项] [文件夹路径...]
计算指定文件夹中视频文件的总时长。
选项:
  -r        递归处理子目录中的视频文件
  -a        包含隐藏文件和文件夹中的视频
  -p, --pwd 计算当前目录下的视频时长
  -h, --help 显示本帮助信息
如果没有提供文件夹路径，程序会提示输入。
```

```bash
./calculate_video_duration.sh
请输入要计算视频时长的文件夹路径（多个路径用空格分隔）: /home/xxx/Downloads/xxx
所有文件夹的总时长为: 5 小时 22 分钟

./calculate_video_duration.sh
请输入要计算视频时长的文件夹路径（多个路径用空格分隔）: /home/xxx/Downloads/aaa /home/xxx/Downloads/bbb
所有文件夹的总时长为: 7 小时 37 分钟
```
## 传入文件夹路径

```bash
./calculate_video_duration.sh /home/xxx/Downloads/aaa /home/xxx/Downloads/bbb /home/xxx/Downloads/ccc
所有文件夹的总时长为: 11 小时 58 分钟
```
---

# calculate_video_duration_linux
Calculate the total video duration of a folder under Linux

deployment：`ffmpeg` `find`
# Preparation before use
Step 1: Download the script

Step 2: Give execution permissions
```bash
chmod +x calculate_video_duration_en.sh
```
# How to use

## Use directly
```bash
./calculate_video_duration_en.sh
```

```bash
./calculate_video_duration_en.sh -h
Usage: /home/xxx/Fastapps/calculate_video_duration_en.sh [options] [folder paths...]
Calculate total duration of video files in specified folders.
Options:
  -r        Process subdirectories recursively
  -a        Include hidden files and folders
  -p, --pwd Calculate duration in current directory
  -h, --help Show this help message
If no folder paths are provided, the script will prompt for input.
```

```bash
./calculate_video_duration_en.sh
Enter folder path(s) to calculate video duration (separate with spaces):  /home/xxx/Downloads/xxx
Total duration of all videos: 6 hours 36 minutes

./calculate_video_duration.sh
Enter folder path(s) to calculate video duration (separate with spaces):/home/xxx/Downloads/aaa /home/xxx/Downloads/bbb
Total duration of all videos: 7 hours 37 minutes
```
## Follow the folder path

```bash
./calculate_video_duration_en.sh /home/xxx/Downloads/aaa /home/xxx/Downloads/bbb /home/xxx/Downloads/ccc
Total duration of all videos: 11 hours 58 minutes
```


