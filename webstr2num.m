function [ num ] = webstr2num( str )
%% Description webstr2num ���Խ�web�ַ�������תΪ����
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

