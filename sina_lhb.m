function [ lhb ] = sina_lhb( tradedate )
%% Description sina_lhb ��ȡ����������������
%% Inputs:
%  tradedate  ��������
%% Outputs:
%  lhb    ������������
%% 
    switch nargin
        case 0 
            tradedate = datestr(date, 'yyyy-mm-dd');     
        case 1
            try
                tradedate = datestr(tradedate, 'yyyy-mm-dd');     
            catch
                error('�������������');
            end
    end
    try
        page= urlread(strcat('http://vip.stock.finance.sina.com.cn/q/go.php/vInvestConsult/kind/lhb/index.phtml?tradedate=',tradedate),'Charset','GB2312');
        exp = 'blank\D*(?<code>\d{6})\D{2}a\D*\d{6}\D*blank\D{2}(?<name>\D*)\D{2}a>\D*\d*\D*>(?<close>\S*)\D{2}t\D*\d*\D*>(?<value>\S*)\D{2}t\D*>(?<volume>\S*)\D{2}t\D*>(?<amt>\S*)\D{2}t[^;]*��(?<reason>\S*)\D{1}emsp\D{2}emsp';
        lhb=struct2table(regexp(page,exp,'names'));

        lhb.close = data.web.webstr2num(lhb.close);  % ���̼�
        lhb.value = data.web.webstr2num(lhb.value); % �������Ӧֵ
        lhb.volume = data.web.webstr2num(lhb.volume);  % �ɽ���
        lhb.amt = data.web.webstr2num(lhb.amt);  % �ɽ���
        lhb.tradedate = repmat(tradedate,size(lhb.code));
    catch
        lhb = [];
        disp('������');
    end
end

