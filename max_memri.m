function [ y ] = max_memri( W0, D, Ron, Roff,u,input_ampl, FREQUENCY )
%MAX_MEMRI Summary of this function goes here
%   Detailed explanation goes here

R0=Ron*W0/D+Roff*(1-W0/D);

k2=(1-Roff/Ron)*(Ron/D)^2*u;

y = sqrt(R0^2 + 2*k2*input_ampl./(pi*FREQUENCY));

end

