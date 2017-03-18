function [ num ] = webstr2num( str )
%% Description webstr2num 尝试将web字符型数字转为数字
%% Inputs:
%  str   
%% Outputs:
%  num    
%%
    num = nan(size(str));
    try
        num = cellfun(@str2num, strrep(str,',',''));
    catch
        loc = strcmp({'--'},str);
        num(~loc) = cellfun(@str2num, strrep(str(~loc),',',''));
    end
end

