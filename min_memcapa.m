function [ y ] = min_memcapa( C_init, C_max, C_min, kappa,input_ampl,FREQUENCY)
%MIN_MEMCAPA Calculates the minimum capacitance for the mathematical
%memcapacitor for a sinusoidal input
%   The FREQUENCY can be a vector


D_max = 1/C_min;
D_min = 1/C_max;
D0 = 1/C_init;
delta_D = D_max - D_min;

y = 1./sqrt(D0^2 + 2*delta_D*kappa*input_ampl./(pi*FREQUENCY));

end