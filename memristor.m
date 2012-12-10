function [ m, i ,q ] = memristor( W0, D, Ron, Roff,u , input_v , integr_v, t, TIME_STEP )
%MEMRISTOR Summary of this function goes here
%   Detailed explanation goes here

R0=Ron*W0/D+Roff*(1-W0/D);

k2=(1-Roff/Ron)*(Ron/D)^2*u;
%% Calculation of the output current value

 m=zeros(1,length(t));
 for j=1:length(t)
    m(j)=1/sqrt(R0^2+2*k2*integr_v(j));  
 end
 
 i = input_v.*m;
 
 q = diff(i)/TIME_STEP;


end

