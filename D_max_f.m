function [ ret ] = D_max_f(delta_D, kappa, A, D0, f  )
%D_MAX_F Summary of this function goes here
%   Detailed explanation goes here

ret = D0*sqrt(1+2*delta_D*kappa*A/(D0^2*pi*f));
end

