# Linux下视频时长计算器
计算某文件夹下视频总计时长
依赖：`ffmpeg`
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
deployment：`ffmpeg`
# Preparation before use
Step 1: Download the script

Step 2: Give execution permissions
```bash
chmod +x calculate_video_duration.sh
```
# How to use

## Use directly
```bash
./calculate_video_duration.sh
```

```bash
./calculate_video_duration.sh
请输入要计算视频时长的文件夹路径（多个路径用空格分隔）: /home/xxx/Downloads/xxx
所有文件夹的总时长为: 5 小时 22 分钟

./calculate_video_duration.sh
请输入要计算视频时长的文件夹路径（多个路径用空格分隔）: /home/xxx/Downloads/aaa /home/xxx/Downloads/bbb
所有文件夹的总时长为: 7 小时 37 分钟
```
## Follow the folder path

```bash
./calculate_video_duration.sh /home/xxx/Downloads/aaa /home/xxx/Downloads/bbb /home/xxx/Downloads/ccc
所有文件夹的总时长为: 11 小时 58 分钟
```


