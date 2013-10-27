function [ V_in, time_v ] = input_test_b( cycles, PULSE_PAUSE, PULSE_LENGTH, VOLTAGE_MAX, VOLTAGE_STEP, TIME_STEP )
%INPUT_RESULTS Summary of this function goes here
%   Detailed explanation goes here

cycles = (cycles <= 0)*1 + (cycles>0)*floor(cycles);

time_end = cycles*2*(PULSE_LENGTH + PULSE_PAUSE)* (floor((VOLTAGE_MAX-VOLTAGE_STEP)/ VOLTAGE_STEP)+ 1);

amp_vector = [VOLTAGE_STEP:VOLTAGE_STEP:VOLTAGE_MAX];
amp_vector = horzcat(amp_vector, -fliplr(amp_vector));

if (time_end<PULSE_LENGTH)
    time_end=PULSE_LENGTH;
end


time_v = [0:TIME_STEP:time_end];

time_v_mod = mod( time_v , PULSE_PAUSE + PULSE_LENGTH);
tic

V_in = (time_v_mod <= PULSE_PAUSE )*0 + (time_v_mod > PULSE_PAUSE ).*amp_vector(mod(floor(time_v./(PULSE_LENGTH + PULSE_PAUSE)),length(amp_vector))+1);            

toc    

end

