function [ ret ] = input_sine( t, A , f )
%INPUT_SINE This is a fuction of a sine with arguments for amplitude and
%frequency
%   Detailed explanation goes here

ret = A*sin(2*pi*f*t);

end

