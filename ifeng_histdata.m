function [ histdata ] = ifeng_histdata( code,ktype)
%% Description ifeng_histdata 获取凤凰财经历史数据
%% Inputs:
%  code   证券代码
%  date   日期
%% Outputs:
%  histdata    历史数据
    %% 
    %获取全部历史数据
    symbol=data.web.code_to_symbol(code);
    switch ktype
        case {'d','D'}
            page=urlread(['http://api.finance.ifeng.com/akdaily/?code=',symbol,'&type=last']);
        case {'w','W'}
            page=urlread(['http://api.finance.ifeng.com/akweekly/?code=',symbol,'&type=last']);
        case {'m','M'}
            page=urlread(['http://api.finance.ifeng.com/akmonthly/?code=',symbol,'&type=last']);
        case {'5','15','30','60'}
            page=urlread(['http://api.finance.ifeng.com/akmin?scode=',symbol,'&type=',ktype]);
        case {5,15,30,60}
            page=urlread(['http://api.finance.ifeng.com/akmin?scode=',symbol,'&type=',num2str(ktype)]);
        otherwise
            error('ktype error: should in d , w, m, 5, 15, 30, 60')
    end
    switch ktype
        case {'d','D','w','W','m','M'}
        exp='(?<datetime>\d{4}\-\d{2}\-\d{2})\","(?<open>\d*\.\d*|\d*)\","(?<high>\d*\.\d*|\d*)\","(?<close>\d*\.\d*|\d*)\","(?<low>\d*\.\d*|\d*)\","(?<volume>\d*\.\d*|\d*)\","(?<p_change>\d*\.\d*|-\d*\.\d*)\"';
        case {'5','15','30','60',5,15,30,60}
        exp='(?<datetime>\d{4}\-\d{2}\-\d{2}\s*\d{2}:\d{2}:\d{2})\"\,\"(?<open>\d*\.\d*|\d*)\"\,\"(?<high>\d*\.\d*|\d*)\"\,\"(?<close>\d*\.\d*|\d*)\"\,\"(?<low>\d*\.\d*|\d*)\"\,(?<volume>\d*\.\d*|\d*)\,"(?<p_change>\d*\.\d*|-\d*\.\d*)\"';
    end
        histdata=regexp(page,exp,'names');
        histdata=struct2table(histdata);
        % 用cellfun(@str2num, cell)将str转为num
        histdata.datetime = cellfun(@datenum, histdata.datetime);
        histdata.open = cellfun(@str2num, histdata.open);
        histdata.high = cellfun(@str2num, histdata.high);
        histdata.low = cellfun(@str2num, histdata.low);
        histdata.close = cellfun(@str2num, histdata.close);
        histdata.volume = cellfun(@str2num, histdata.volume);
        histdata.p_change = cellfun(@str2num, histdata.p_change);
        histdata = [table(datestr(histdata.datetime),'VariableNames',{'datetimestr'}) histdata];
end

