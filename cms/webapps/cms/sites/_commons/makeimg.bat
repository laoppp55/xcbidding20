ffmpeg.exe -i %1 -y -f image2 -ss 5 -t 0.001 -s 250x170 %2 2>encode.txt