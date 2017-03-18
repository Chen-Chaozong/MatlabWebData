function [ hygzd ] = sina_hygzd( ndays )
%% Description sina_lhbtj ��ȡ������ҵ��ע��
%% Inputs:
%  ndays  ������,10 30 60
%% Outputs:
%  hygzd    ��ҵ��ע��
    if nargin<1
        ndays = 10;
    elseif ~any(ndays == [10,30,60])
        ndays = 10;
    end
    try
        page= urlread(strcat('http://vip.stock.finance.sina.com.cn/q/go.php/vIR_IndustryCare/index.phtml?last=',num2str(ndays),'&num=1000'),'Charset','GB2312');
        exp = '<td>(?<industry>\S*)<\D*>(?<industry_counts>\S*)<\D*>(?<stock_counts>\S*)<\D*>(?<buy_counts>\S*)<\D*>(?<hold_counts>\S*)<\D*>(?<neutral_counts>\S*)<\D*>(?<reduce_counts>\S*)<\D*>(?<sell_counts>\S*)</td>';
        hygzd=struct2table(regexp(page,exp,'names'));

        hygzd.industry_counts = getdata.web.webstr2num(hygzd.industry_counts);  % ��ע��
        hygzd.stock_counts = getdata.web.webstr2num(hygzd.stock_counts);  % ��ע��Ʊ��
        hygzd.buy_counts = getdata.web.webstr2num(hygzd.buy_counts);  % ����������
        hygzd.hold_counts = getdata.web.webstr2num(hygzd.hold_counts);  % ����������        
        hygzd.neutral_counts = getdata.web.webstr2num(hygzd.neutral_counts);  % ����������        
        hygzd.reduce_counts = getdata.web.webstr2num(hygzd.reduce_counts);  % ����������
        hygzd.sell_counts = getdata.web.webstr2num(hygzd.sell_counts);  % ����������
        hygzd.date = repmat(datestr(date, 'yyyy-mm-dd'),size(hygzd.industry));
    catch
        hygzd = [];
        disp('������');
    end
end

