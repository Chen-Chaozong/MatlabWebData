function [ tickdata ] = sina_tickdata( code,datetime )
%% Description sina_tickdata ��ȡ����tick����
%% Inputs:
%  code   ֤ȯ����
%  date   ����
%% Outputs:
%  tickdata    tick����
%% 
    if nargin < 2
        datetime = datestr(date,'yyyy-mm-dd');
    else
        datetime = datestr(datetime,'yyyy-mm-dd');
    end
    symbol=getdata.web.code_to_symbol(code);
    str= urlread(['http://market.finance.sina.com.cn/downxls.php?date=',datetime, '&symbol=',symbol],'Charset','GB18030');
    exp='(?<datetime>\d{2}:\d{2}:\d{2})\s*(?<price>\d*\.\d{2})\s*(\S*)\s*(?<volumns>\d*)\s*(?<amount>\d*)\s*(?<type>\S*)';
    stru=regexp(str,exp,'names');
    tickdata=struct2table(stru);
    tickdata.datetime = datenum(strcat(datetime,{' '},tickdata.datetime));
    tickdata.price=cellfun(@str2num, tickdata.price);
    tickdata.volumns=cellfun(@str2num, tickdata.volumns);
    tickdata.amount=cellfun(@str2num, tickdata.amount);
    if isempty(stru)
        disp('�޵�������')
    end
    tickdata = [table(datestr(tickdata.datetime),'VariableNames',{'datetimestr'}) tickdata];
    tickdata=sortrows(tickdata,'datetime');
end

