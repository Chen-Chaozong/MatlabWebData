function [ cwfx ] = sina_cwfx( type,datayear,dataquarter )
%% Description sina_cwfx ��ȡ���˲����������
%% Inputs:
%  type   ����������ͣ�'profit','operation','grow','debtpaying','cashflow','mainindex','performance','news','incomedetail'
%  datayear   �������
%  dataquarter  ���漾��
%% Outputs:
%  cwfx    �����������
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
                error('�����������Ϊ1��2��3��4֮һ');
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
            exp = 'center\D*(?<code>\d{6})\D*blank\D{2}(?<name>\D*)\D{2}a\D*d>(?<roe>\D*\d*.\d*)\D{2}t\D*d>(?<netprofitmargin>\D*\d*.\d*)\D{2}t\D*d>(?<profitmargin>\D*\d*.\d*)\D{2}t\D*d>(?<netprofit>\D*\d*.\d*)\D{2}t\D*d>(?<eps>\D*\d*.\d*)\D{2}t\D*d>(?<income>\D*\d*.\d*)\D{2}t\D*d>(?<mips>\D*\d*.\d*)';
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
                cwfx.eps = data.web.webstr2num(cwfx.eps);
                cwfx.yeps = data.web.webstr2num(cwfx.yeps);
                cwfx.epsrate = data.web.webstr2num(cwfx.epsrate);
                cwfx.netprofit = data.web.webstr2num(cwfx.netprofit);
                cwfx.netprofitrate = data.web.webstr2num(cwfx.netprofitrate);
                cwfx.navps = data.web.webstr2num(cwfx.navps);
                cwfx.roe = data.web.webstr2num(cwfx.roe);
                cwfx.sumnavps = data.web.webstr2num(cwfx.sumnavps);
            case 'operation'
                cwfx.yszkzzl = data.web.webstr2num(cwfx.yszkzzl);  % Ӧ���˿���ת��
                cwfx.yszkzzts = data.web.webstr2num(cwfx.yszkzzts); % Ӧ���˿���ת����
                cwfx.chzzl = data.web.webstr2num(cwfx.chzzl);  % �����ת��
                cwfx.chzzts = data.web.webstr2num(cwfx.chzzts);  % �����ת����
                cwfx.ldzczzl = data.web.webstr2num(cwfx.ldzczzl);  % �����ʲ���ת��
                cwfx.ldzczzts = data.web.webstr2num(cwfx.ldzczzts);  % �����ʲ���ת����
            case 'grow'
                cwfx.mainincome = data.web.webstr2num(cwfx.mainincome);  % ��Ӫҵ������������
                cwfx.netprofit = data.web.webstr2num(cwfx.netprofit); % ������������
                cwfx.netassets = data.web.webstr2num(cwfx.netassets);  % ���ʲ�������
                cwfx.totalassets = data.web.webstr2num(cwfx.totalassets);  % ���ʲ�������
                cwfx.eps = data.web.webstr2num(cwfx.eps);  % ÿ������������
                cwfx.sgr = data.web.webstr2num(cwfx.sgr);  % �ɶ�Ȩ��������
            case 'debtpaying'
                cwfx.current = data.web.webstr2num(cwfx.current);  % ��������
                cwfx.quick = data.web.webstr2num(cwfx.quick); % �ٶ�����
                cwfx.cash = data.web.webstr2num(cwfx.cash);  % �ֽ����
                cwfx.icr = data.web.webstr2num(cwfx.icr);  % ��Ϣ֧������
                cwfx.equity = data.web.webstr2num(cwfx.equity);  % �ɶ�Ȩ�����
                cwfx.debt2asset = data.web.webstr2num(cwfx.debt2asset);  % �ʲ���ծ��
            case 'cashflow'            
                cwfx.cashflow2income = data.web.webstr2num(cwfx.cashflow2income);  % ��Ӫ�ֽ������������������
                cwfx.cashflowrepay = data.web.webstr2num(cwfx.cashflowrepay); % �ʲ��ľ�Ӫ�ֽ������ر���
                cwfx.cashflow2netprofit = data.web.webstr2num(cwfx.cashflow2netprofit);  % ��Ӫ�ֽ������뾻����ı���
                cwfx.cashflow2debt = data.web.webstr2num(cwfx.cashflow2debt);  % ��Ӫ�ֽ������Ը�ծ�ı���
                cwfx.cashflow = data.web.webstr2num(cwfx.cashflow);  % �ֽ���������
            case 'mainindex'
                cwfx.eps = data.web.webstr2num(cwfx.eps);  % ÿ������
                cwfx.epsrate = data.web.webstr2num(cwfx.epsrate); % ÿ������ͬ��
                cwfx.navps = data.web.webstr2num(cwfx.navps);  % ÿ�ɾ��ʲ�
                cwfx.roe = data.web.webstr2num(cwfx.roe);  % ��Ӫ�ֽ������Ը�ծ�ı���
                cwfx.cps = data.web.webstr2num(cwfx.cps);  % �ֽ���������
                cwfx.netprofit = data.web.webstr2num(cwfx.netprofit);  % ��Ӫ�ֽ������Ը�ծ�ı���
                cwfx.netprofitrate = data.web.webstr2num(cwfx.netprofitrate);  % �ֽ���������
            case 'performance'
                cwfx.pre_eps = data.web.webstr2num(cwfx.pre_eps);  % ����ͬ��ÿ������
            case 'news'            
                cwfx.eps = data.web.webstr2num(cwfx.eps);  % ÿ������
                cwfx.yeps = data.web.webstr2num(cwfx.yeps); % Ӫҵ���루��Ԫ��
                cwfx.epsrate = data.web.webstr2num(cwfx.epsrate);  % Ӫҵ����ͬ��
                cwfx.netprofit = data.web.webstr2num(cwfx.netprofit);  % ��������Ԫ��
                cwfx.netprofitrate = data.web.webstr2num(cwfx.netprofitrate);  % ������ͬ��
                cwfx.navps = data.web.webstr2num(cwfx.navps);  % ÿ�ɾ��ʲ���Ԫ��
                cwfx.roe = data.web.webstr2num(cwfx.roe);  % ���ʲ�������
                cwfx.sumnavps = data.web.webstr2num(cwfx.sumnavps);  % ���ʲ�����Ԫ��
            case 'incomedetail'
                cwfx.income = data.web.webstr2num(cwfx.income);  % ÿ������
                cwfx.cost = data.web.webstr2num(cwfx.cost); % Ӫҵ���루��Ԫ��
                cwfx.profit = data.web.webstr2num(cwfx.profit);  % Ӫҵ����ͬ��
        end
        cwfx.year = repmat(datayear,size(cwfx.code));
        cwfx.quarter = repmat(dataquarter,size(cwfx.code));
    catch
        display('������');
    end
end

