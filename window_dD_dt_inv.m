function [ dD ] = window_dD_dt_inv( t,D,delta_D, D_max,kappa, input_fn , window_fn )
%WINDOW_DD_DT_INV Summary of this function goes here
%   Detailed explanation goes here
v = input_fn(t);

dD = - delta_D* kappa * v / D * window_fn( (D - D_max)/delta_D );

end

