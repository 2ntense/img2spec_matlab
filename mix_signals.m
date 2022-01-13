function mixed_signal = mix_signals(s1, s2, s1_gain, s2_gain)
    mixed_signal = (s1*10^(s1_gain/20)) + (s2*10^(s2_gain/20));
end