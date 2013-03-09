function [ str_leg ] = func2legend( fn_handle )
%FUNC2LEGEND Summary of this function goes here
%   Detailed explanation goes here

    str_leg=cell(length(fn_handle),1);
    for ii=1:length(fn_handle)
        temp = func2str(fn_handle{ii});
        str_leg{ii} = regexprep(temp,'@\(x\)window_fn_','');
        str_leg{ii} = regexprep(str_leg{ii},'Prodro\(x,(.*),(.*)\)','Prodromakis j=$1 & p=$2');
        str_leg{ii} = regexprep(str_leg{ii},'Strukov\(x\)','Strukov');
        str_leg{ii} = regexprep(str_leg{ii},'Joglekar\(x,(.*)\)','Joglekar p=$1');
        str_leg{ii} = regexprep(str_leg{ii},'NO_WINDOW\(\)','No Window fn');
    end
end

