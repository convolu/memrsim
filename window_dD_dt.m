function [ dD ] = window_dD_dt( t,D,delta_D, D_min,kappa, input_fn , window_fn )
%WINDOW_DY_DT Summary of this function goes here
%   Detailed explanation goes here

v = input_fn(t);

dD = delta_D* kappa * v / D * window_fn( (D - D_min)/delta_D );

end

