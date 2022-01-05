function out_signal = img2spec(img_path, duration, img_freq_range, img_time_range, samp_rate, freq_step, samp_step)
    img_duration = img_time_range(2) - img_time_range(1);
    img_data = load_img(img_path, freq_step, samp_rate, img_duration);
    img_data = flipud(img_data);
    img_data = transpose(img_data);
    out_signal = zeros(1, duration * samp_rate);
    img_size = size(img_data);

    for x = 1:samp_step:img_size(1)
        idx_start = x + (img_time_range(1) * samp_rate);
        idx_end = idx_start + samp_step - 1;
        signal = zeros(1, samp_step);
        if min(img_data(x,:)) == 255
            out_signal(idx_start:idx_end) = signal;
            continue;
        end
        for y = img_size(2):-1:1
            if img_data(x,y) < 255
                amp = 1 - img_data(x, y) / 255;
                rescaled_freq = rescale_val(freq_step * y, img_freq_range(2), img_freq_range(1), freq_step * img_size(2), 0);
                signal = signal + gen_wave(rescaled_freq, amp, samp_step, samp_rate);
            end
        end
        out_signal(idx_start:idx_end) = signal;
    end
    out_signal = rescale(out_signal, -1, 1);
end

function img_data = load_img(img_path, freq_step, samp_rate, duration)
    img_data = imread(img_path);
    img_data = im2gray(img_data);
    
    new_rows = (samp_rate / 2) / freq_step;
    new_cols = duration * samp_rate;

    img_data = imresize(img_data, [new_rows new_cols]);
end

function wave = gen_wave(freq, amp, samp_step, samp_rate)
    periods = (samp_step * freq) / samp_rate;
    samples = 1:samp_step;
    wave = double(amp) * sin(periods * 2 * pi * samples / samp_step);
end

function rescaled_val = rescale_val(val, scaled_max, scaled_min, max_val, min_val)
    rescaled_val = scaled_min + (val - min_val) * (scaled_max - scaled_min) / (max_val - min_val);
end