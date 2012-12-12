function [ m, i ,q ] = memristor( W0, D, Ron, Roff,u , input_v , integr_v, t, TIME_STEP )
%MEMRISTOR This function calculates the memristance as a function of time,
%model without a windowing function
%   It uses the standard HP model, it requires both the input and
%   the integrated version of the input

R0=Ron*W0/D+Roff*(1-W0/D);

k2=(1-Roff/Ron)*(Ron/D)^2*u;
%% Calculation of the output current value

 m=zeros(1,length(t));
 for j=1:length(t)
    m(j)=sqrt(R0^2+2*k2*integr_v(j));  
 end
 
 i = input_v./m;
 
 q=TIME_STEP*cumtrapz(i);

end

