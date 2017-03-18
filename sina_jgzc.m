function [ jgzc ] = sina_jgzc( type,datayear,dataquarter )
%% Description sina_jgzc 获取新浪机构重仓数据
%% Inputs:
%  type   机构类型，jjzc,sbzc,qfii
%  datayear   报告年度
%  dataquarter  报告季度
%% Outputs:
%  jgzc    机构重仓数据
%% 
    switch nargin
        case 0 
            type = 'jjzc';            
            datayear = year(date);
            dataquarter = quarter(date)-1;
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
                error('季度输入错误，为1，2，3，4之一');
            end
    end
    if ~any(strcmp(type,{'jjzc','sbzc','qfii'}))
        error('type error, should in jjzc, sbzc, qfii');
    end
    datayear = num2str(datayear);
    dataquarter = num2str(dataquarter);
    page= urlread(strcat('http://vip.stock.finance.sina.com.cn/q/go.php/vComStockHold/kind/',type,'/index.phtml?symbol=%D6%A4%C8%AF%BC%F2%B3%C6%BB%F2%B4%FA%C2%EB&reportdate=',datayear,'&quarter=',dataquarter,'&num=3000'),'Charset','GB2312');
    exp = 'center\D*(?<code>\d{6})\D*blank\D{2}(?<name>\D*)</a>\D*(?<date>\d{4}-\d{2}-\d{2})\D*(?<fundnum>\d*)\D*(?<hold>\d*.\d*)\D*(?<holdratio>\d*.\d*)\D*d\D{1}(?<holdchg>\D*\d*.\d*)\D*(?<fundraio>\d*.\d*)\D*(?<prefundnum>\d*)';
    stru=regexp(page,exp,'names');
    jgzc=struct2table(stru);
    jgzc.fundnum=cellfun(@str2num, jgzc.fundnum);
    jgzc.hold=cellfun(@str2num, jgzc.hold);
    jgzc.holdratio=cellfun(@str2num, jgzc.holdratio);
    jgzc.holdchg=cellfun(@str2num, jgzc.holdchg);
    jgzc.fundraio=cellfun(@str2num, jgzc.fundraio);
    jgzc.prefundnum=cellfun(@str2num, jgzc.prefundnum);
    if isempty(stru)
        display('无当日数据')
    end
end

