function [ dzjy ] = sina_dzjy(datanum, pagenum )
%% Description sina_dzjy 获取新浪大宗交易数据
%% Inputs:
%  tradedate  交易日期
%% Outputs:
%  dzjy   大宗交易数据
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

        dzjy.price = getdata.web.webstr2num(dzjy.price);  % 成交价
        dzjy.volume = getdata.web.webstr2num(dzjy.volume); % 成交量
        dzjy.amt = getdata.web.webstr2num(dzjy.amt);  % 成交额
    catch
        dzjy = [];
        disp('无数据');
    end 
end

