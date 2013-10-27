clearvars
close all

VOLTAGE_STEP = 0.5;
VOLTAGE_MAX = 5.5;
PULSE_LENGTH = 0.5e-6;
PULSE_PAUSE = 1e-6;
TIME_STEP = 1e-9;

[B,A]=input_test_b( 1 , PULSE_PAUSE, PULSE_LENGTH, VOLTAGE_MAX, VOLTAGE_STEP, TIME_STEP );

% cycles = 10.9;
% cycles = (cycles <= 0)*1 + (cycles>0)*floor(cycles);
% 
% time_end = cycles*2*(PULSE_LENGTH + PULSE_PAUSE)* (floor((VOLTAGE_MAX-VOLTAGE_STEP)/ VOLTAGE_STEP)+ 2 + floor((VOLTAGE_MAX-2*VOLTAGE_STEP)/ VOLTAGE_STEP));

amp = input_custom_pulse_pre_amp_b( VOLTAGE_MAX, VOLTAGE_STEP );

for i=1:length(A)
    B2(i) = input_custom_pulse(A(i),amp, PULSE_PAUSE, PULSE_LENGTH);
end


plot(A,B-B2);
% plot(A,B2);