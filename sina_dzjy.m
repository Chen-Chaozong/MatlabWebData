function [ dzjy ] = sina_dzjy(datanum, pagenum )
%% Description sina_dzjy ��ȡ���˴��ڽ�������
%% Inputs:
%  tradedate  ��������
%% Outputs:
%  dzjy   ���ڽ�������
%% 
    if nargin <1
        datanum =100;
    end
    if nargin <2
        pagenum =1;
    end
    try
        page= urlread(strcat('http://vip.stock.finance.sina.com.cn/q/go.php/vInvestConsult/kind/dzjy/index.phtml?num=',num2str(datanum),'&p=',num2str(pagenum)),'Charset','GB2312');
        exp = '<td>(?<date>\d{4}-\d{2}-\d{2})<\D*\d*\D*>(?<code>\d{6})<\D*\d*\D*>(?<name>\S*)</a>\D*>(?<price>\S*)<\D*>(?<volume>\S*)<\D*>(?<amt>\S*)<\D*">(?<buyer>\S*)<\D*">(?<seller>\S*)<\D*<td>(?<type>\S{2})\D*</tr>';
        dzjy=struct2table(regexp(page,exp,'names'));

        dzjy.price = getdata.web.webstr2num(dzjy.price);  % �ɽ���
        dzjy.volume = getdata.web.webstr2num(dzjy.volume); % �ɽ���
        dzjy.amt = getdata.web.webstr2num(dzjy.amt);  % �ɽ���
    catch
        dzjy = [];
        disp('������');
    end 
end

