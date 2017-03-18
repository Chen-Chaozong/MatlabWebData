function [ lsfh ] = sina_lsfh(datanum,pagenum)
%% Description sina_lsfh ��ȡ������ʷ�ֺ�����
%% Inputs:
%  datanum  ��������
%% Outputs:
%  dzjy   ��ʷ�ֺ�����
%% 
    if nargin <1
        datanum =10000;
    end
    if nargin <2
        pagenum =1;
    end
    try
        page= urlread(strcat('http://vip.stock.finance.sina.com.cn/q/go.php/vInvestConsult/kind/lsfh/index.phtml?num=',num2str(datanum),'&p=',num2str(pagenum)),'Charset','GB2312');
        exp = 'blank">(?<code>\d{6})<\D*\d*\D*>(?<name>\S*)</a>\D*>(?<ipodate>\S*)<\D*>(?<cumdiv>\S*)<\D*>(?<avgdiv>\S*)<\D*>(?<divtimes>\S*)<\D*>(?<totfinancing>\S*)<\D*>(?<numfinancing>\S*)</td>';
        lsfh=struct2table(regexp(page,exp,'names'));

        lsfh.cumdiv = getdata.web.webstr2num(lsfh.cumdiv);  % �ۼƹ�Ϣ��
        lsfh.avgdiv = getdata.web.webstr2num(lsfh.avgdiv); % �����Ϣ��
        lsfh.divtimes = getdata.web.webstr2num(lsfh.divtimes);  % �ֺ����
        lsfh.totfinancing = getdata.web.webstr2num(lsfh.totfinancing);  % �����ܶ��Ԫ��
        lsfh.numfinancing = getdata.web.webstr2num(lsfh.numfinancing);  % ���ʴ���
        lsfh.ipodate = datestr(lsfh.ipodate,'yyyy-mm-dd');
    catch
        lsfh = [];
        disp('������');
    end 
end

