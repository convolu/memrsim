function [ ret ] = get_line_style( index )
%GET_LINE_STYLE Summary of this function goes here
%   Detailed explanation goes here

line_style = {'-','-.'};

if mod(index,length(line_style))==0
    ret = line_style{end};
else
    ret = line_style{mod(index,length(line_style))};
end

end

