# Usage example

```
img2spec("smiley_double.png", "img2spec.wav", 5, [8000 10000], [2 3], 48000, 200, 1000)
```
```
img2spec(img_path, out_path, duration, img_freq_range, img_time_range, samp_rate, freq_step, samp_step)

img_path: absolute path of the image
out_path: absolute path of wav file to write to
duration: duration (seconds) of the whole signal
img_freq_range: 1x2 matrix with the lower and upper frequency bounds
img_time_range: 1x2 matrix with the  lower and upper time (seconds) bounds
samp_rate: sampling rate/sampling frequency (usually 22050 or 44100 or 48000)
freq_step: make sure its a divisor of samp_rate/2
samp_step: make sure its a divisor of samp_rate
```
