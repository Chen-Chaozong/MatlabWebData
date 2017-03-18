function [ xsjj ] = sina_xsjj( startdate, enddate )
%% Description sina_xsjj 获取新浪限售股解禁
%% Inputs:
%  tradedate  交易日期
%% Outputs:
%  xsjj    限售股解禁
%% 
    if nargin < 2
        enddate = datestr(datetime+datenum(0,0,15), 'yyyy-mm-dd');     
    end
    if nargin < 1
        startdate = datestr(datetime-datenum(0,0,15), 'yyyy-mm-dd');
    end
    try
        page= urlread(strcat('http://vip.stock.finance.sina.com.cn/q/go.php/vInvestConsult/kind/xsjj/index.phtml?bdate=',startdate,'&edate=',enddate,'&num=10000'),'Charset','GB2312');
        exp = 'blank">(?<code>\d{6})<\D*\d*\D*>(?<name>\S*)</a><\D*>(?<publicdate>\S*)<\D*>(?<batch>\S*)<\D*>(?<liftdate>\S*)<\D*>(?<liftnum>\S*)<\D*>(?<liftmarketvalue>\S*)</td>';
        xsjj=struct2table(regexp(page,exp,'names'));

        xsjj.batch = getdata.web.webstr2num(xsjj.batch);  % 上市批次
        xsjj.liftnum = getdata.web.webstr2num(xsjj.liftnum);  % 解禁数量
        xsjj.liftmarketvalue = getdata.web.webstr2num(xsjj.liftmarketvalue);  % 解禁股流通市值
        xsjj.publicdate = datestr(xsjj.publicdate,'yyyy-mm-dd');
        xsjj.liftdate = datestr(xsjj.liftdate,'yyyy-mm-dd');
        xsjj.startdate = repmat(startdate,size(xsjj.code));
        xsjj.enddate = repmat(enddate,size(xsjj.code));
    catch
        xsjj = [];
        disp('无数据');
    end
end

