function [ lhb ] = sina_lhb( tradedate )
%% Description sina_lhb 获取新浪龙虎榜日数据
%% Inputs:
%  tradedate  交易日期
%% Outputs:
%  lhb    龙虎榜日数据
%% 
    switch nargin
        case 0 
            tradedate = datestr(date, 'yyyy-mm-dd');     
        case 1
            try
                tradedate = datestr(tradedate, 'yyyy-mm-dd');     
            catch
                error('交易日输入错误');
            end
    end
    try
        page= urlread(strcat('http://vip.stock.finance.sina.com.cn/q/go.php/vInvestConsult/kind/lhb/index.phtml?tradedate=',tradedate),'Charset','GB2312');
        exp = 'blank\D*(?<code>\d{6})\D{2}a\D*\d{6}\D*blank\D{2}(?<name>\D*)\D{2}a>\D*\d*\D*>(?<close>\S*)\D{2}t\D*\d*\D*>(?<value>\S*)\D{2}t\D*>(?<volume>\S*)\D{2}t\D*>(?<amt>\S*)\D{2}t[^;]*：(?<reason>\S*)\D{1}emsp\D{2}emsp';
        lhb=struct2table(regexp(page,exp,'names'));

        lhb.close = data.web.webstr2num(lhb.close);  % 收盘价
        lhb.value = data.web.webstr2num(lhb.value); % 龙虎榜对应值
        lhb.volume = data.web.webstr2num(lhb.volume);  % 成交量
        lhb.amt = data.web.webstr2num(lhb.amt);  % 成交额
        lhb.tradedate = repmat(tradedate,size(lhb.code));
    catch
        lhb = [];
        disp('无数据');
    end
end

