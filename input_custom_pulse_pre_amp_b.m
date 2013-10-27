function [ amp ] = input_custom_pulse_pre_amp_b( VOLTAGE_MAX, VOLTAGE_STEP )
%INPUT_CUSTOM_PULSE_PRE Summary of this function goes here
%   Detailed explanation goes here

amp = [VOLTAGE_STEP:VOLTAGE_STEP:VOLTAGE_MAX];
amp = horzcat(amp, -fliplr(amp));

end

