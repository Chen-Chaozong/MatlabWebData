function [ nbjy ] = sina_nbjy(datanum, pagenum )
%% Description sina_dzjy 获取新浪公司内部交易数据
%% Inputs:
%  datanum  单次抓取数量
%  pagenum  页面号码
%% Outputs:
%  nbjy   公司内部交易数据
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

        nbjy.number = getdata.web.webstr2num(nbjy.number);  % 变动股数
        nbjy.avgprice = getdata.web.webstr2num(nbjy.avgprice); % 成交均价
        nbjy.amt = getdata.web.webstr2num(nbjy.amt);  % 变动金额
        nbjy.after = getdata.web.webstr2num(nbjy.after);  % 变动后持股数
    catch
        nbjy = [];
        disp('无数据');
    end 
end

