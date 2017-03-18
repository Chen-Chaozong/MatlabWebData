function [ trzrq, drzrq ] = sina_rzrq( tradedate )
%% Description sina_lhb 获取新浪融资融券数据
%% Inputs:
%  tradedate  交易日期
%% Outputs:
%  rzrq    融资融券数据
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
        page= urlread(strcat('http://vip.stock.finance.sina.com.cn/q/go.php/vInvestConsult/kind/rzrq/index.phtml?tradedate=',tradedate),'Charset','GB2312');
        texp = 'd>(?<market>\D{2})<\D*>(?<rzye>\S*)<\D*>(?<rzmr>\S*)<\D*>(?<rqch>\S*)<\D*>(?<rqye>\S*)\D{2}t';
        dexp = '>(?<code>\d{6})<\D*\d*\D*k">(?<name>\S*)</a\D*f">(?<rzye>\S*)</t\D*f">(?<rzmr>\S*)</t\D*f">(?<rzch>\S*)</t\D*f">(?<rqyl_je>\S*)</t\D*f">(?<rqyl>\S*)</t\D*f">(?<rqmc>\S*)</t\D*f">(?<rqch>\S*)</t\D*f">(?<rqye>\S*)<\D*tr';
        
        trzrq=struct2table(regexp(page,texp,'names'));
        trzrq.rzye = getdata.web.webstr2num(trzrq.rzye);  % 融资余额
        trzrq.rzmr = getdata.web.webstr2num(trzrq.rzmr); % 融资买入额
        trzrq.rqch = getdata.web.webstr2num(trzrq.rqch);  % 融券偿还额
        trzrq.rqye = getdata.web.webstr2num(trzrq.rqye);  % 融券余额
        trzrq.tradedate = repmat(tradedate,size(trzrq.code));
        							
        drzrq=struct2table(regexp(page,dexp,'names'));
        drzrq.rzye = getdata.web.webstr2num(drzrq.rzye);  % 融资余额(元)
        drzrq.rzmr = getdata.web.webstr2num(drzrq.rzmr);  % 融资买入额(元)
        drzrq.rzch = getdata.web.webstr2num(drzrq.rzch);  % 融资偿还额(元)
        drzrq.rqyl_je = getdata.web.webstr2num(drzrq.rqyl_je);  % 余量金额(元)
        drzrq.rqyl = getdata.web.webstr2num(drzrq.rqyl);  % 余量(股)
        drzrq.rqmc = getdata.web.webstr2num(drzrq.rqmc);  % 卖出量(股)
        drzrq.rqch = getdata.web.webstr2num(drzrq.rqch);  % 偿还量(股)
        drzrq.rqye = getdata.web.webstr2num(drzrq.rqye);  % 融券余额(元)
        drzrq.tradedate = repmat(tradedate,size(drzrq.code));
    catch
        trzrq = [];
        drzrq = [];
        disp('无数据');
    end
end

