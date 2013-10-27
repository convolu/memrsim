function [ str_leg ] = freq2legend( freq )
%FREQ2LEGEND Summary of this function goes here
%   Detailed explanation goes here

str_leg=cell(length(freq),1);
for ii=1:length(freq)
    str_leg{ii} = sprintf('%0.3g Hz',freq(ii));
end


end

