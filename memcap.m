function [ c,q,integr_q ] = memcap( C_init, C_max, C_min, kappa, input_v , integr_v, t, TIME_STEP)
%MEMCAP Summary of this function goes here
%   Detailed explanation goes here

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
integr_q=zeros(1,length(t));
for j=1:length(t)
    integr_q(j)=TIME_STEP*trapz(q(1:j));
end

end

