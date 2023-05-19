# [FFmpeg](https://www.ffmpeg.org/) hardware transcoding (nvidia)

## h264/AAC -> DNxHR/PCM (with hardware decoding, deinterlace and clip-cut)
```
ffmpeg -ss 00:03:50.00 -c:v h264_cuvid -i ./CLIP.MTS -vf bwdif -c:v dnxhd -c:a pcm_s16le -profile:v dnxhr_sq -pix_fmt yuv422p -f mov -t 00:00:15.00 ./clip.mov
```

## h264/AAC -> DNxHR/PCM (with hardware decoding and clip-cut)
```
ffmpeg -ss 00:04:45.00 -c:v h264_cuvid -i ./CLIP.MP4 -c:v dnxhd -c:a pcm_s16le -profile:v dnxhr_sq -pix_fmt yuv422p -f mov -t 00:00:10.00 ./clip.mov
```

## h264/AAC -> MJPEG/PCM
```
ffmpeg -i ./CLIP.MP4 -vcodec mjpeg -q:v 2 -acodec pcm_s16be -q:a 0 -f mov out.mov
```

## DNxHR/PCM -> h264/AAC (yt)
```
ffmpeg -i clip.mov -codec:v h264_nvenc -bf 2 -flags +cgop -pix_fmt yuv420p -b:v 12M -codec:a aac -strict -2 -b:a 384k -r:a 48000 -movflags faststart clip.mp4
```

## DNxHR/PCM -> h265/AAC (hq)
```
ffmpeg -i ./clip.mov -c:v hevc_nvenc -preset slow -rc cbr -cbr 1 -2pass 1 -b:v 20M -c:a aac -b:a 384k ./clip.mp4
```

## DNxHR/PCM -> h265/AAC (yt)
```
ffmpeg -i ./clip.mov -c:v hevc_nvenc -preset slow -rc vbr -b:v 12M -c:a aac -b:a 384k ./clip.mp4
```

<br />




# [FFmpeg](https://www.ffmpeg.org/) screengrab

## linux
```
ffmpeg -f x11grab -video_size 1024x768 -i $DISPLAY -s 1024x768 -r 25 -preset ultrafast -b:v 10M output.mp4
```

## windows
```
ffmpeg -f gdigrab -video_size 1920x1200 -i desktop -s 1920x1200 -r 30 -preset ultrafast -b:v 10M wingrab.mp4
```

## screengrab with visible region
```
ffmpeg -f x11grab -video_size 1080x608 -show_region 1 -grab_x 100 -grab_y 100 -i $DISPLAY -s 1080x608 -r 25 -preset ultrafast -b:v 10M output.mp4
```

<br />




# [FFmpeg](https://www.ffmpeg.org/) edit

## video cut (no rerender)
```
ffmpeg -ss 00:00:00.00 -i input.mp4 -c copy -t 01:01:00.00 output.mp4
```

## animated gif
```
ffmpeg -ss 00:00:43.5 -i input.mp4 -t 00:00:02.00 -r 15 -s 480x270 output.gif
```

## double the speed of the video
```
ffmpeg -i input.mp4 -filter:v "setpts=0.5*PTS" output.mp4
```

## rotate 180' during recoding
```
ffmpeg -i input.mp4 -vf "transpose=2,transpose=2" output.mp4
```

## force frame rate (30fps)
```
ffmpeg -i input.mp4 -r:v 30 output.mp4
```

## deshake
```
ffmpeg -i input.mp4 -vf vidstabdetect=shakiness=10:accuracy=15 -f null -

ffmpeg -i input.mp4 -vf vidstabtransform=zoom=5:smoothing=30 -vcodec libx264 -preset slow -tune film -crf 20 -an output.mp4
```

## merge audio to video
```
ffmpeg -i video.mp4 -i audio.wav -c:v copy -c:a aac -shortest output.mp4
```

## extract audio from video
```
ffmpeg -i video.mp4 -vn -acodec copy output.m4a
```

<br />




# [FFmpeg](https://www.ffmpeg.org/) mp3 encoding

# cbr
```
ffmpeg -i input.audioformat -c:a libmp3lame -b:a 256k output.mp3
```

# vbr
```
ffmpeg -i input.audioformat -c:a libmp3lame -q:a 0 output.mp3
```
