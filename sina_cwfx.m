function [ cwfx ] = sina_cwfx( type,datayear,dataquarter )
%% Description sina_cwfx 获取新浪财务分析数据
%% Inputs:
%  type   财务分析类型，'profit','operation','grow','debtpaying','cashflow','mainindex','performance','news','incomedetail'
%  datayear   报告年度
%  dataquarter  报告季度
%% Outputs:
%  cwfx    财务分析数据
%% 
    switch nargin
        case 0 
            type = 'profit';            
            datayear = year(date);
            dataquarter = floor(month(date)/3);
            if dataquarter == 0
                datayear = datayear-1;
                dataquarter = 4;
            end
        case 1
            datayear = year(date);
            dataquarter = quarter(date)-1;
            if dataquarter == 0
                datayear = datayear-1;
                dataquarter = 4;
            end
        case 2
            dataquarter = quarter(date)-1;
            if dataquarter == 0
                datayear = datayear-1;
                dataquarter = 4;
            end
        case 3
            if ~any(dataquarter == [1,2,3,4,'1','2','3','4'])
                error('季度输入错误，为1，2，3，4之一');
            end
    end
    if ~any(strcmp(type,{'profit','operation','grow','debtpaying','cashflow','mainindex','performance','news','incomedetail'}))
        error('type error, should in profit, operation, grow, debtpaying, cashflow, mainindex, performance,  , incomedetail');
    end
    datayear = num2str(datayear);
    dataquarter = num2str(dataquarter);
    page= urlread(strcat('http://vip.stock.finance.sina.com.cn/q/go.php/vFinanceAnalyze/kind/',type,'/index.phtml?reportdate=',datayear,'&quarter=',dataquarter,'&num=10000'),'Charset','GB2312');
    switch type
        case 'profit'
            exp = 'q=(?<code>\d{6})&contry\D*_blank">(?<name>\D*)</a>\D*<td>(?<roe>\S*)</td>\D*<td>(?<netprofitmargin>\S*)</td>\D*<td>(?<profitmargin>\S*)</td>\D*<td>(?<netprofit>\S*)</td>\D*<td>(?<eps>\S*)</td>\D*<td>(?<income>\S*)</td>\D*<td>(?<mips>\S*)</td>';
        case 'operation'
            exp = 'center\D*(?<code>\d{6})\D*blank\D{2}(?<name>\D*)\D{2}a\D*d>(?<yszkzzl>\S*)\D{2}t\D*d>(?<yszkzzts>\S*)\D{2}t\D*d>(?<chzzl>\S*)\D{2}t\D*d>(?<chzzts>\S*)\D{2}t\D*d>(?<ldzczzl>\S*)\D{2}t\D*d>(?<ldzczzts>\S*)\D{2}t';
        case 'grow'
            exp = 'center\D*(?<code>\d{6})\D*blank\D{2}(?<name>\D*)\D{2}a\D*d>(?<mainincome>\S*)\D{2}t\D*d>(?<netprofit>\S*)\D{2}t\D*d>(?<netassets>\S*)\D{2}t\D*d>(?<totalassets>\S*)\D{2}t\D*d>(?<eps>\S*)\D{2}t\D*d>(?<sgr>\S*)\D{2}t';
        case 'debtpaying'
            exp = 'center\D*(?<code>\d{6})\D*blank\D{2}(?<name>\D*)\D{2}a\D*d>(?<current>\S*)\D{2}t\D*d>(?<quick>\S*)\D{2}t\D*d>(?<cash>\S*)\D{2}t\D*d>(?<icr>\S*)\D{2}t\D*d>(?<equity>\S*)\D{2}t\D*d>(?<debt2asset>\S*)\D{2}t';
        case 'cashflow'
            exp = 'center\D*(?<code>\d{6})\D*blank\D{2}(?<name>\D*)\D{2}a\D*d>(?<cashflow2income>\S*)\D{2}t\D*d>(?<cashflowrepay>\S*)\D{2}t\D*d>(?<cashflow2netprofit>\S*)\D{2}t\D*d>(?<cashflow2debt>\S*)\D{2}t\D*d>(?<cashflow>\S*)\D{2}t';
        case 'mainindex'
            exp = 'blank\D*(?<code>\d{6})\D{2}a\D*\d{2}\D*\d{6}\D*\d{6}\D*blank\D{2}(?<name>\D*)\D{6}s\D*d>(?<eps>\S*)\D{2}t\D*d>(?<epsrate>\S*)\D{2}t\D*d>(?<navps>\S*)\D{2}t\D*d>(?<roe>\S*)\D{2}t\D*d>(?<cps>\S*)\D{2}t\D*d>(?<netprofit>\S*)\D{2}t\D*d>(?<netprofitrate>\S*)\D{2}t\D*d>(?<dividendplan>\S*)\D{2}t\D*d>(?<date>\S*)\D{2}t';
        case 'performance'
            exp = 'blank\D*(?<code>\d{6})\D{2}a\D*\d{2}\D*\d{6}\D*\d{6}\D*blank\D{2}(?<name>\D*)\D{6}span\D*\d*\D*">(?<type>\S*)\D{2}a\D*d>(?<publicdate>\S*)\D{2}t\D*d>(?<reportdate>\S*)\D{2}t\D*">(?<summary>\S*)\D{2}t\D*d>(?<pre_eps>\S*)\D{2}t\D*d>(?<egr>\S*)\D{2}t';
        case 'news'
            exp = 'blank\D*(?<code>\d{6})\D{2}a\D*\d{2}\D*\d{6}\D*\d{6}\D*blank\D{2}(?<name>\D*)\D{6}s\D*d>(?<eps>\S*)\D{2}t\D*d>(?<yeps>\S*)\D{2}t\D*d>(?<epsrate>\S*)\D{2}t\D*d>(?<netprofit>\S*)\D{2}t\D*d>(?<netprofitrate>\S*)\D{2}t\D*d>(?<navps>\S*)\D{2}t\D*d>(?<roe>\S*)\D{2}t\D*d>(?<sumnavps>\S*)\D{2}t\D*d>(?<publicdate>\S*)\D{2}t';
        case 'incomedetail'
            exp = 'stock\D*(?<code>\d{6})\D{2}a\D*\d{2}\D*\d{6}\D*stock\D{2}(?<name>\D*)\D{2}a\D*d>(?<industry>\S*)\D{2}t\D*d>(?<income>\S*)\D{2}t\D*d>(?<cost>\S*)\D{2}t\D*d>(?<profit>\S*)\D{2}t\D*d>(?<summary>\S*)\D{2}t\D*d>(?<publicdate>\S*)\D{2}t';
    end
    try
        cwfx=struct2table(regexp(page,exp,'names'));
        switch type
            case 'profit'
                cwfx.roe = webstr2num(cwfx.roe);
                cwfx.netprofitmargin = webstr2num(cwfx.netprofitmargin);
                cwfx.profitmargin = webstr2num(cwfx.profitmargin);
                cwfx.netprofit = webstr2num(cwfx.netprofit);
                cwfx.eps = webstr2num(cwfx.eps);
                cwfx.income = webstr2num(cwfx.income);
                cwfx.mips = webstr2num(cwfx.mips);
            case 'operation'
                cwfx.yszkzzl = webstr2num(cwfx.yszkzzl);  % 应收账款周转率
                cwfx.yszkzzts = webstr2num(cwfx.yszkzzts); % 应收账款周转天数
                cwfx.chzzl = webstr2num(cwfx.chzzl);  % 存货周转率
                cwfx.chzzts = webstr2num(cwfx.chzzts);  % 存货周转天数
                cwfx.ldzczzl = webstr2num(cwfx.ldzczzl);  % 流动资产周转率
                cwfx.ldzczzts = webstr2num(cwfx.ldzczzts);  % 流动资产周转天数
            case 'grow'
                cwfx.mainincome = webstr2num(cwfx.mainincome);  % 主营业务收入增长率
                cwfx.netprofit = webstr2num(cwfx.netprofit); % 净利润增长率
                cwfx.netassets = webstr2num(cwfx.netassets);  % 净资产增长率
                cwfx.totalassets = webstr2num(cwfx.totalassets);  % 总资产增长率
                cwfx.eps = webstr2num(cwfx.eps);  % 每股收益增长率
                cwfx.sgr = webstr2num(cwfx.sgr);  % 股东权益增长率
            case 'debtpaying'
                cwfx.current = webstr2num(cwfx.current);  % 流动比率
                cwfx.quick = webstr2num(cwfx.quick); % 速动比率
                cwfx.cash = webstr2num(cwfx.cash);  % 现金比率
                cwfx.icr = webstr2num(cwfx.icr);  % 利息支付倍数
                cwfx.equity = webstr2num(cwfx.equity);  % 股东权益比率
                cwfx.debt2asset = webstr2num(cwfx.debt2asset);  % 资产负债率
            case 'cashflow'            
                cwfx.cashflow2income = webstr2num(cwfx.cashflow2income);  % 经营现金净流量对销售收入比率
                cwfx.cashflowrepay = webstr2num(cwfx.cashflowrepay); % 资产的经营现金流量回报率
                cwfx.cashflow2netprofit = webstr2num(cwfx.cashflow2netprofit);  % 经营现金净流量与净利润的比率
                cwfx.cashflow2debt = webstr2num(cwfx.cashflow2debt);  % 经营现金净流量对负债的比率
                cwfx.cashflow = webstr2num(cwfx.cashflow);  % 现金流量比率
            case 'mainindex'
                cwfx.eps = webstr2num(cwfx.eps);  % 每股收益
                cwfx.epsrate = webstr2num(cwfx.epsrate); % 每股收益同比
                cwfx.navps = webstr2num(cwfx.navps);  % 每股净资产
                cwfx.roe = webstr2num(cwfx.roe);  % 经营现金净流量对负债的比率
                cwfx.cps = webstr2num(cwfx.cps);  % 现金流量比率
                cwfx.netprofit = webstr2num(cwfx.netprofit);  % 经营现金净流量对负债的比率
                cwfx.netprofitrate = webstr2num(cwfx.netprofitrate);  % 现金流量比率
            case 'performance'
                cwfx.pre_eps = webstr2num(cwfx.pre_eps);  % 上年同期每股收益
            case 'news'            
                cwfx.eps = webstr2num(cwfx.eps);  % 每股收益
                cwfx.yeps = webstr2num(cwfx.yeps); % 营业收入（万元）
                cwfx.epsrate = webstr2num(cwfx.epsrate);  % 营业收入同比
                cwfx.netprofit = webstr2num(cwfx.netprofit);  % 净利润（万元）
                cwfx.netprofitrate = webstr2num(cwfx.netprofitrate);  % 净利润同比
                cwfx.navps = webstr2num(cwfx.navps);  % 每股净资产（元）
                cwfx.roe = webstr2num(cwfx.roe);  % 净资产收益率
                cwfx.sumnavps = webstr2num(cwfx.sumnavps);  % 总资产（万元）
            case 'incomedetail'
                cwfx.income = webstr2num(cwfx.income);  % 每股收益
                cwfx.cost = webstr2num(cwfx.cost); % 营业收入（万元）
                cwfx.profit = webstr2num(cwfx.profit);  % 营业收入同比
        end
        cwfx.year = repmat(datayear,size(cwfx.code));
        cwfx.quarter = repmat(dataquarter,size(cwfx.code));
    catch
        disp('无数据');
    end
end

