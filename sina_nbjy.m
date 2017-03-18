function [ nbjy ] = sina_nbjy(datanum, pagenum )
%% Description sina_dzjy ��ȡ���˹�˾�ڲ���������
%% Inputs:
%  datanum  ����ץȡ����
%  pagenum  ҳ�����
%% Outputs:
%  nbjy   ��˾�ڲ���������
%% 
    if nargin <1
        datanum =100;
    end
    if nargin <2
        pagenum =1;
    end
    try
        page= urlread(strcat('http://vip.stock.finance.sina.com.cn/q/go.php/vInvestConsult/kind/nbjy/index.phtml?num=',num2str(datanum),'&p=',num2str(pagenum)),'Charset','GB2312');
        exp = 'blank">(?<code>\d{6})<\D*\d*\D*\d*\D*>(?<name>\S*)</a>\D*>(?<people>\S*)</td>\D*\d*\D*">(?<type>\S*)</font>\D*\d*\D*">(?<number>\S*)</font>\D*>(?<avgprice>\S*)</td>\D*>(?<amt>\S*)<\D*>(?<after>\S*)<\D*>(?<reason>\S*)<\D*>(?<date>\S*)<\D*>(?<stocktype>\S*)<\D*>(?<relation>\S*)<\D*>(?<work>\S*)</td>';
        nbjy=struct2table(regexp(page,exp,'names'));

        nbjy.number = getdata.web.webstr2num(nbjy.number);  % �䶯����
        nbjy.avgprice = getdata.web.webstr2num(nbjy.avgprice); % �ɽ�����
        nbjy.amt = getdata.web.webstr2num(nbjy.amt);  % �䶯���
        nbjy.after = getdata.web.webstr2num(nbjy.after);  % �䶯��ֹ���
    catch
        nbjy = [];
        disp('������');
    end 
end

