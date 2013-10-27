function [ ret ] = get_line_spec( index )
%GET_LINE_SPEC Summary of this function goes here
%   Detailed explanation goes here

line_spec = {'-r','-g','-b','-c','-m','-k','-.r','-.g','-.b','-.c','-.m','-.k'};

if mod(index,length(line_spec))==0
    ret = line_spec{end};
else
    ret = line_spec{mod(index,length(line_spec))};
end
end

