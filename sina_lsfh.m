function [ lsfh ] = sina_lsfh(datanum,pagenum)
%% Description sina_lsfh 获取新浪历史分红数据
%% Inputs:
%  datanum  交易日期
%% Outputs:
%  dzjy   历史分红数据
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

        lsfh.cumdiv = getdata.web.webstr2num(lsfh.cumdiv);  % 累计股息率
        lsfh.avgdiv = getdata.web.webstr2num(lsfh.avgdiv); % 年均股息率
        lsfh.divtimes = getdata.web.webstr2num(lsfh.divtimes);  % 分红次数
        lsfh.totfinancing = getdata.web.webstr2num(lsfh.totfinancing);  % 融资总额（亿元）
        lsfh.numfinancing = getdata.web.webstr2num(lsfh.numfinancing);  % 融资次数
        lsfh.ipodate = datestr(lsfh.ipodate,'yyyy-mm-dd');
    catch
        lsfh = [];
        disp('无数据');
    end 
end

