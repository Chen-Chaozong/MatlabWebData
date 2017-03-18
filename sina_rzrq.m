function [ trzrq, drzrq ] = sina_rzrq( tradedate )
%% Description sina_lhb ��ȡ����������ȯ����
%% Inputs:
%  tradedate  ��������
%% Outputs:
%  rzrq    ������ȯ����
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
        page= urlread(strcat('http://vip.stock.finance.sina.com.cn/q/go.php/vInvestConsult/kind/rzrq/index.phtml?tradedate=',tradedate),'Charset','GB2312');
        texp = 'd>(?<market>\D{2})<\D*>(?<rzye>\S*)<\D*>(?<rzmr>\S*)<\D*>(?<rqch>\S*)<\D*>(?<rqye>\S*)\D{2}t';
        dexp = '>(?<code>\d{6})<\D*\d*\D*k">(?<name>\S*)</a\D*f">(?<rzye>\S*)</t\D*f">(?<rzmr>\S*)</t\D*f">(?<rzch>\S*)</t\D*f">(?<rqyl_je>\S*)</t\D*f">(?<rqyl>\S*)</t\D*f">(?<rqmc>\S*)</t\D*f">(?<rqch>\S*)</t\D*f">(?<rqye>\S*)<\D*tr';
        
        trzrq=struct2table(regexp(page,texp,'names'));
        trzrq.rzye = getdata.web.webstr2num(trzrq.rzye);  % �������
        trzrq.rzmr = getdata.web.webstr2num(trzrq.rzmr); % ���������
        trzrq.rqch = getdata.web.webstr2num(trzrq.rqch);  % ��ȯ������
        trzrq.rqye = getdata.web.webstr2num(trzrq.rqye);  % ��ȯ���
        trzrq.tradedate = repmat(tradedate,size(trzrq.code));
        							
        drzrq=struct2table(regexp(page,dexp,'names'));
        drzrq.rzye = getdata.web.webstr2num(drzrq.rzye);  % �������(Ԫ)
        drzrq.rzmr = getdata.web.webstr2num(drzrq.rzmr);  % ���������(Ԫ)
        drzrq.rzch = getdata.web.webstr2num(drzrq.rzch);  % ���ʳ�����(Ԫ)
        drzrq.rqyl_je = getdata.web.webstr2num(drzrq.rqyl_je);  % �������(Ԫ)
        drzrq.rqyl = getdata.web.webstr2num(drzrq.rqyl);  % ����(��)
        drzrq.rqmc = getdata.web.webstr2num(drzrq.rqmc);  % ������(��)
        drzrq.rqch = getdata.web.webstr2num(drzrq.rqch);  % ������(��)
        drzrq.rqye = getdata.web.webstr2num(drzrq.rqye);  % ��ȯ���(Ԫ)
        drzrq.tradedate = repmat(tradedate,size(drzrq.code));
    catch
        trzrq = [];
        drzrq = [];
        disp('������');
    end
end

