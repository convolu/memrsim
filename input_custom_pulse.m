function [ V_in ] = input_custom_pulse( t, amp_vector , PULSE_PAUSE , PULSE_LENGTH )
%INPUT_CUSTOM_PULSE Summary of this function goes here
%   Detailed explanation goes here

time_v_mod = mod( t , PULSE_PAUSE + PULSE_LENGTH);

V_in = (time_v_mod <= PULSE_PAUSE )*0 + (time_v_mod > PULSE_PAUSE ).*amp_vector(mod(floor(t./(PULSE_LENGTH + PULSE_PAUSE)),length(amp_vector))+1);            
   
end

