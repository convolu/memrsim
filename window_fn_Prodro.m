function [ out ] = window_fn_Prodro( x , jj , p )
%WINDOWFN Windowing Function proposed by Prodromakis et al.
%   j controls fmax and p its steepnes

out = jj * ( 1 - ((x-0.5)^2 + 0.75 )^p );

end

