# Virtual Audio

## pulseaudio

### sink
```
$ pacmd load-module module-null-sink sink_name=MySink
$ pacmd update-sink-proplist MySink device.description=MySink
```

### loopback device
```
$ pacmd load-module module-loopback sink=MySink
```

## alsa
```
# modprobe snd_aloop
```
