function [ lhbtj ] = sina_lhbtj( type,ndays )
%% Description sina_lhbtj 获取新浪龙虎榜统计
%% Inputs:
%  type   龙虎榜统计类型，'ggtj','yytj','jgzz'
%  ndays  近几天,5 10 30 60
%% Outputs:
%  lhbtj    龙虎榜统计
%% 
    switch nargin
        case 0 
            type = 'ggtj';            
            ndays = 5;
        case 1          
            ndays = 5;
    end
    if ~any(strcmp(type,{'ggtj','yytj','jgzz'}))
        error('type error, should in ggtj, yytj, jgzz');
    end
    if ~any(ndays == [5,10,30,60] | strcmp(ndays,{'5','10','30','60'}))
        error('ndays error, should in 5 10 30 60');
    end
    ndays = num2str(ndays);
    page= urlread(strcat('http://vip.stock.finance.sina.com.cn/q/go.php/vLHBData/kind/',type,'/index.phtml?last=',ndays,'&num=10000'),'Charset','GB2312');
    switch type
        case 'ggtj'
            exp = 'blank\D{2}(?<code>\d{6})[^"]*\D{1}[^>]*>(?<name>\S*)\D{2}a\D*d>(?<time>\S*)\D{2}t\D*d>(?<cumbuy>\S*)\D{2}t\D*d>(?<cumsell>\S*)\D{2}t\D*d>(?<netvalue>\S*)\D{2}t\D*d>(?<buynum>\S*)\D{2}t\D*d>(?<sellnum>\S*)\D{2}t';
        case 'yytj'
            exp = '[^>]*>(?<name>\S*)\D{2}a\D*d>(?<time>\S*)\D{2}t\D*d>(?<cumbuy>\S*)\D{2}t\D*d>(?<buynum>\S*)\D{2}t\D*d>(?<cumsell>\S*)\D{2}t\D*d>(?<sellnum>\S*)\D{2}t\D*d>(?<symbols>\S*)\D{2}t';
        case 'jgzz'
            exp = 'blank\D{2}(?<code>\d{6})[^"]*\D{1}[^>]*>(?<name>\S*)\D{2}a[^"]*\D{1}[^"]*\D{1}[^"]*\D{1}[^"]*\D{1}\D*d>(?<cumbuy>\S*)\D{2}t\D*d>(?<buytime>\S*)\D{2}t\D*d>(?<cumsell>\S*)\D{2}t\D*d>(?<selltime>\S*)\D{2}t\D*d>(?<netvalue>\S*)\D{2}t';
    end
    try
        lhbtj=struct2table(regexp(page,exp,'names'));
        switch type
            case 'ggtj'
                lhbtj.time = data.web.webstr2num(lhbtj.time);
                lhbtj.cumbuy = data.web.webstr2num(lhbtj.cumbuy);
                lhbtj.cumsell = data.web.webstr2num(lhbtj.cumsell);
                lhbtj.netvalue = data.web.webstr2num(lhbtj.netvalue);
                lhbtj.buynum = data.web.webstr2num(lhbtj.buynum);
                lhbtj.sellnum = data.web.webstr2num(lhbtj.sellnum);
            case 'yytj'
                lhbtj.time = data.web.webstr2num(lhbtj.time);  % 上榜次数
                lhbtj.cumbuy = data.web.webstr2num(lhbtj.cumbuy); % 累计买入额
                lhbtj.buynum = data.web.webstr2num(lhbtj.buynum);  % 买入席位数
                lhbtj.cumsell = data.web.webstr2num(lhbtj.cumsell);  % 累计卖出额
                lhbtj.sellnum = data.web.webstr2num(lhbtj.sellnum);  % 卖出席位数
            case 'jgzz'
                lhbtj.cumbuy = data.web.webstr2num(lhbtj.cumbuy);  % 累计买入额
                lhbtj.buytime = data.web.webstr2num(lhbtj.buytime); % 买入次数
                lhbtj.cumsell = data.web.webstr2num(lhbtj.cumsell);  % 累计卖出额
                lhbtj.selltime = data.web.webstr2num(lhbtj.selltime);  % 卖出次数
                lhbtj.netvalue = data.web.webstr2num(lhbtj.netvalue);  % 净额
        end
    catch
        disp('无数据');
    end    
    lhbtj.datetime = repmat(date,size(lhbtj(:,1)));
end

