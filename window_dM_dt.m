function [ dM ] = window_dM_dt( t,M,Ron,Roff,mu,L,input_fn,window_fn )
%WINDOW_DM_DT Summary of this function goes here
%   Detailed explanation goes here

v = input_fn(t);

dM = (Ron-Roff)*mu*Ron/L^2 * v/M * window_fn( (M - Roff)/(Ron-Roff) );

end

