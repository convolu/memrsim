function [ amp ] = input_custom_pulse_pre_amp( VOLTAGE_MAX, VOLTAGE_STEP )
%INPUT_CUSTOM_PULSE_PRE Summary of this function goes here
%   Detailed explanation goes here

amp = horzcat([VOLTAGE_STEP:VOLTAGE_STEP:VOLTAGE_MAX],[(VOLTAGE_MAX-VOLTAGE_STEP):-VOLTAGE_STEP:VOLTAGE_STEP]);
amp = horzcat(amp, -amp);

end

