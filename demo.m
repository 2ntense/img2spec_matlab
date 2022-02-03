audio_file = "in.wav";
out_file = "out.wav";
img_file = "txt.png";
samp_rate = 44100;
duration = 30;
start_freq = 19000;
end_freq = 20000;
start_time = 0;
end_time = 30;
freq_step = 25;
samp_step = 490;

lorem_ispum = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas at commodo odio. Sed nec porta odio. Donec ante mi, eleifend non nunc at, finibus posuere ipsum. Phasellus tempor scelerisque ultricies. Nulla quam lorem, eleifend vitae volutpat quis, eleifend et sapien.";

imwrite(text2im(lorem_ispum), img_file);
img_signal = img2spec(img_file, duration, [start_freq end_freq], [start_time end_time], samp_rate, freq_step, samp_step);
audio_signal = audioread(audio_file);

% Determine gain required for 55 dB SNR
mixed_signal = mix_signals(audio_signal, img_signal, 0, 0);
base_snr = snr(audio_signal, mixed_signal - audio_signal);
db_diff = 55 - base_snr;
mixed_signal = mix_signals(audio_signal, img_signal, 0, -db_diff);

% show_spec(mixed_signal, 1024, 1024*0.75, 0:(samp_rate/2), samp_rate);

signal_to_noise = snr(audio_signal, mixed_signal - audio_signal);

audiowrite(out_file, mixed_signal, samp_rate);

function show_spec(signal, win_size, win_overlap, freq_range, samp_rate)
    spectrogram(signal, win_size, win_overlap, freq_range, samp_rate, "yaxis");
end