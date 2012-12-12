function [ c,q,cur ] = memcap( C_init, C_max, C_min, kappa, input_v , integr_v, t, TIME_STEP)
%MEMCAP This function calculates the memcapacitance as a function of time
%   It uses the standard mathematical model, it requires both the input and
%   the integrated version of the input

D_max = 1/C_min;
D_min = 1/C_max;
D0 = 1/C_init;
delta_D = D_max - D_min;

%% Calculation of the output charge value

c=zeros(1,length(t));
 for m=1:length(t)
    c(m)=1/sqrt(D0^2+2*delta_D*kappa*integr_v(m));  
 end
 
 q = input_v.*c;
 
  %% Calculation of the output current

cur = diff(q)/TIME_STEP;
 
cur(end+1) = cur(end);

end

