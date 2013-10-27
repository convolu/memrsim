function [ ret ] = get_line_colour( index )
%GET_LINE_COLOUR Summary of this function goes here
%   Detailed explanation goes here

line_colour = {'r','g','b','m','k'};

if mod(index,length(line_colour))==0
    ret = line_colour{end};
else
    ret = line_colour{mod(index,length(line_colour))};
end
end